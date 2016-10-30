//
//  BirdSprite.swift
//  day
//
//  Created by Benjamin Stammen on 10/30/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class BirdSprite : SKSpriteNode {
    
    override init(texture: SKTexture!, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
