//
//  BirdSprite.swift
//  day
//
//  Created by Benjamin Stammen on 10/30/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class BirdSprite : SKSpriteNode {
    
    var beakTexture : SKTexture?
    var bodyTexture : SKTexture?
    var eggTexture : SKTexture?
    var timeBetweenEggs: Float = 10.0
    
    init(beakTexture: SKTexture, bodyTexture: SKTexture, eggTexture: SKTexture, timeBetweenEggs: Float) {
        super.init(texture: bodyTexture, color: UIColor.red, size: bodyTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
