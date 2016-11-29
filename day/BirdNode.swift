//
//  BirdNode.swift
//  day
//
//  Created by Benjamin Stammen on 10/30/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class BirdNode : SKSpriteNode {

    static let indicatorNodeName = "eggIndicator"
    
    
    var eggTexture : SKTexture
    var featherTexture : SKTexture
    var timeBetweenEggs: Float
    var timeUntilNextEgg: Float
    private var eggValue: Int
    
    var leftWing : SKNode
    var rightWing : SKNode
    
    private var featherParticleEmitter : SKEmitterNode?
    private var particleSpawnRate: CGFloat?
    
    private var idling : Bool = true
    
    init(templateFile: String, timeBetweenEggs: Float, eggTexture: SKTexture, featherTexture: SKTexture, eggValue: Int) {
        
        let importedScene = SKScene(fileNamed: templateFile)
        let bodyNode: SKSpriteNode = importedScene!.childNode(withName: "//body") as! SKSpriteNode

        self.eggTexture = eggTexture
        self.featherTexture = featherTexture
        self.timeBetweenEggs = timeBetweenEggs
        self.timeUntilNextEgg = timeBetweenEggs
        self.eggValue = eggValue
        self.leftWing = bodyNode.childNode(withName: "//left_wing")!
        self.rightWing = bodyNode.childNode(withName: "//right_wing")!
        
        super.init(texture: nil, color: bodyNode.color, size: bodyNode.size)
        self.zPosition = GameConstants.LayerConstants.CharacterLayer
        self.anchorPoint = bodyNode.anchorPoint
        self.name = "bird"
        bodyNode.zPosition = -1
        bodyNode.removeFromParent()
        self.addChild(bodyNode)
        
        self.configurePhysics()
        
        self.startIdleAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePhysics() {
        let physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: -self.frame.width/2, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        physicsBody.isDynamic = true
        physicsBody.fieldBitMask = GameConstants.PhysicsConstants.BirdPhysicsLayer
        physicsBody.categoryBitMask = GameConstants.PhysicsConstants.BirdPhysicsLayer
        physicsBody.contactTestBitMask = GameConstants.PhysicsConstants.BirdPhysicsLayer | GameConstants.PhysicsConstants.EggPhysicsLayer
        physicsBody.collisionBitMask = 0
        self.physicsBody = physicsBody
    }
    
    func configureParticles() {
        self.featherParticleEmitter = SKEmitterNode(fileNamed: "feathers.sks")
        self.featherParticleEmitter?.particleTexture = self.featherTexture
        self.featherParticleEmitter?.name = "feather_emitter"
        self.featherParticleEmitter?.targetNode = self.scene
        self.particleSpawnRate = (featherParticleEmitter?.particleBirthRate)!
        self.featherParticleEmitter?.particleBirthRate = 0;
        self.addChild(featherParticleEmitter!)
    }
    
    func startFlutterAction(withParticles : Bool) {
        if self.childNode(withName: "feather_emitter") == nil && withParticles {
            self.configureParticles()
        }

        self.leftWing.removeAllActions()
        self.rightWing.removeAllActions()

        self.leftWing.zRotation = -1.309
        self.rightWing.zRotation = 1.309
        self.leftWing.run(SKAction(named: "fly_left")!)
        self.rightWing.run(SKAction(named: "fly_right")!)
        
        // add feather particles
        if (withParticles) {
            self.featherParticleEmitter?.particleBirthRate = self.particleSpawnRate!
        }
        
        self.idling = false
    }
    
    func startIdleAction() {
        self.leftWing.removeAllActions()
        self.rightWing.removeAllActions()
        
        self.leftWing.zRotation = 0.0
        self.rightWing.zRotation = 0.0
        
        self.leftWing.run(SKAction(named:"flap_left")!)
        self.rightWing.run(SKAction(named:"flap_right")!)
        
        // stop spawning feathers
        self.featherParticleEmitter?.particleBirthRate = 0
        
        self.idling = true
    }
    
    func updateBird(deltaTime: Float) {
        if (idling) {
            self.timeUntilNextEgg = self.timeUntilNextEgg - deltaTime
            if (self.timeUntilNextEgg <= 0.0) {
                self.layEgg()
            } else if (self.timeUntilNextEgg <= 3.0 && (self.childNode(withName: BirdNode.indicatorNodeName) == nil)) {
                // add an indicator that shows that an egg must be laid soon
                let indicatorNode = EggIndicatorNode(bird: self)
                indicatorNode.name = BirdNode.indicatorNodeName
                indicatorNode.position = CGPoint(x: 0, y: self.frame.size.height * 0.9)
                self.addChild(indicatorNode)
            }
        }
    }
        
    
    func layEgg() {
        // add egg to scene
        let egg = EggNode(sourceBird: self, eggTexture: self.eggTexture, eggValue: self.eggValue)
        egg.position = (self.scene?.convert(CGPoint.zero, from: self))!
        self.scene?.addChild(egg)
        
        self.timeUntilNextEgg = self.timeBetweenEggs
        
        self.childNode(withName: BirdNode.indicatorNodeName)?.removeFromParent()
    }
}
