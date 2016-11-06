//
//  BirdSprite.swift
//  day
//
//  Created by Benjamin Stammen on 10/30/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class BirdSprite : SKSpriteNode {

    let warningObjectName = "warning"
    let EggPhysicsLayer    : UInt32 = 0x1 << 1
    let ChickenPhysicsLayer: UInt32 = 0x1 << 2
    
    var eggTexture : SKTexture
    var timeBetweenEggs: Float = 10.0
    var timeUntilNextEgg: Float = 10.0
    
    init(beakTexture: SKTexture, bodyTexture: SKTexture, eggTexture: SKTexture, timeBetweenEggs: Float) {
        
        self.eggTexture = eggTexture
        
        super.init(texture: bodyTexture, color: UIColor.red, size: bodyTexture.size())
        
        // add the beak as a child
        let beakSprite = SKSpriteNode(texture: beakTexture, size: beakTexture.size())
        beakSprite.position = CGPoint(x: 0, y: bodyTexture.size().height / 2)
        beakSprite.zPosition = 2;
        self.addChild(beakSprite)
        
        // make the anchor point at the bottom
        self.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        
        self.addPhysics()
    }
    
    init(templateFile: String, timeBetweenEggs: Float, eggTexture: SKTexture) {
        self.eggTexture = eggTexture
        
        let importedScene = SKScene(fileNamed: templateFile)
        let bodyNode: SKSpriteNode = importedScene!.childNode(withName: "//body") as! SKSpriteNode

        super.init(texture: bodyNode.texture, color: bodyNode.color, size: bodyNode.size)
        self.zPosition = bodyNode.zPosition
        self.anchorPoint = bodyNode.anchorPoint
        
        for child in bodyNode.children {
            child.removeFromParent()
            child.isUserInteractionEnabled = false
            self.addChild(child)
        }
        
        self.addPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPhysics() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: -self.frame.width/2, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        self.physicsBody?.categoryBitMask = self.ChickenPhysicsLayer
        self.physicsBody?.contactTestBitMask = self.ChickenPhysicsLayer | self.EggPhysicsLayer
        self.physicsBody?.collisionBitMask = 0
    }
    
    func updateBird(deltaTime: Float) {
        self.timeUntilNextEgg = self.timeUntilNextEgg - deltaTime
        if (self.timeUntilNextEgg <= 0.0) {
            self.layEgg()
        } else if (self.timeUntilNextEgg <= 3.0 && (self.childNode(withName: "warning") == nil)) {
            // add an indicator that shows that an egg must be laid soon
            let speechTexture = SKTexture(imageNamed: "speech_bubble")
            let warning = SKSpriteNode(texture: speechTexture)
            warning.name = self.warningObjectName
            warning.anchorPoint = CGPoint(x: 1, y: 0)
            warning.position = CGPoint(x:self.frame.size.width/2, y:self.frame.size.height)
            self.addChild(warning);
        }
    }
    
    func layEgg() {
        // add egg to scene
        let egg = SKSpriteNode(texture: eggTexture, size: eggTexture.size())
        egg.zPosition = 3
        egg.physicsBody = SKPhysicsBody(circleOfRadius: eggTexture.size().width/2)
        egg.physicsBody?.categoryBitMask = self.EggPhysicsLayer
        egg.physicsBody?.contactTestBitMask = self.ChickenPhysicsLayer | self.EggPhysicsLayer
        egg.physicsBody?.collisionBitMask = 0
        egg.position = (self.scene?.convert(CGPoint.zero, from: self))!
        self.scene?.addChild(egg)
        
        self.timeUntilNextEgg = self.timeBetweenEggs
        
        self.childNode(withName: self.warningObjectName)?.removeFromParent()
    }
}
