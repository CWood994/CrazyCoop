//
//  BirdNode.swift
//  day
//
//  Created by Benjamin Stammen on 10/30/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class BirdNode : SKSpriteNode {

    let warningObjectName = "warning"
    
    
    var eggTexture : SKTexture
    var timeBetweenEggs: Float
    var timeUntilNextEgg: Float
    private var eggValue: Int
    
    init(templateFile: String, timeBetweenEggs: Float, eggTexture: SKTexture, eggValue: Int) {
        
        let importedScene = SKScene(fileNamed: templateFile)
        let bodyNode: SKSpriteNode = importedScene!.childNode(withName: "//body") as! SKSpriteNode

        self.eggTexture = eggTexture
        self.timeBetweenEggs = timeBetweenEggs
        self.timeUntilNextEgg = timeBetweenEggs
        self.eggValue = eggValue
        super.init(texture: bodyNode.texture, color: bodyNode.color, size: bodyNode.size)
        self.zPosition = bodyNode.zPosition
        self.anchorPoint = bodyNode.anchorPoint
        self.name = "bird"
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
        let physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: -self.frame.width/2, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        physicsBody.isDynamic = true
        physicsBody.categoryBitMask = GameConstants.PhysicsConstants.BirdPhysicsLayer
        physicsBody.contactTestBitMask = GameConstants.PhysicsConstants.BirdPhysicsLayer | GameConstants.PhysicsConstants.EggPhysicsLayer
        physicsBody.collisionBitMask = 0
        self.physicsBody = physicsBody
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
        let egg = EggNode(sourceBird: self, eggTexture: self.eggTexture, eggValue: self.eggValue)
        egg.position = (self.scene?.convert(CGPoint.zero, from: self))!
        self.scene?.addChild(egg)
        
        self.timeUntilNextEgg = self.timeBetweenEggs
        
        self.childNode(withName: self.warningObjectName)?.removeFromParent()
    }
}
