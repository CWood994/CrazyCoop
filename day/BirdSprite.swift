//
//  BirdSprite.swift
//  day
//
//  Created by Benjamin Stammen on 10/30/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class BirdSprite : SKSpriteNode {

    var eggTexture : SKTexture
    var timeBetweenEggs: Float = 10.0
    var timeUntilNextEgg: Float = 10.0
    
    init(beakTexture: SKTexture, bodyTexture: SKTexture, eggTexture: SKTexture, timeBetweenEggs: Float) {
        
        // set eggTexture
        self.eggTexture = eggTexture
        
        super.init(texture: bodyTexture, color: UIColor.red, size: bodyTexture.size())
        
        // add the beak as a child
        let beakSprite = SKSpriteNode(texture: beakTexture, size: beakTexture.size())
        beakSprite.position = CGPoint(x: 0, y: bodyTexture.size().height / 2)
        beakSprite.zPosition = 2;
        self.addChild(beakSprite)
        
        // make the anchor point at the bottom
        self.anchorPoint = CGPoint(x: 0.5, y: 0.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBird(deltaTime: Float) {
        self.timeUntilNextEgg = self.timeUntilNextEgg - deltaTime
        if (self.timeUntilNextEgg <= 0.0) {
            // add egg to scene
            let egg = SKSpriteNode(texture: eggTexture, size: eggTexture.size())
            egg.zPosition = 3
            egg.physicsBody = SKPhysicsBody(circleOfRadius: eggTexture.size().width)
            egg.position = (self.scene?.convert(CGPoint.zero, from: self))!
            self.scene?.addChild(egg)
            
            self.timeUntilNextEgg = self.timeBetweenEggs
        }
    }
}
