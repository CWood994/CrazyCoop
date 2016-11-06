//
//  EggNode.swift
//  day
//
//  Created by Benjamin Stammen on 11/6/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class EggNode : SKSpriteNode {
    
    let sourceBird: BirdNode?
    
    init(sourceBird: BirdNode, eggTexture: SKTexture) {
        self.sourceBird = sourceBird
        super.init(texture: eggTexture, color: UIColor.clear, size: eggTexture.size())
        let physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        physicsBody.categoryBitMask = GameConstants.PhysicsConstants.EggPhysicsLayer
        physicsBody.contactTestBitMask = GameConstants.PhysicsConstants.BirdPhysicsLayer
        physicsBody.collisionBitMask = GameConstants.PhysicsConstants.EggPhysicsLayer
        self.physicsBody = physicsBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
