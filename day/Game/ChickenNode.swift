//
//  ChickenNode.swift
//  day
//
//  Created by Benjamin Stammen on 11/5/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class ChickenNode : BirdNode {
    init() {
        let A: UInt32 = 8
        let B: UInt32 = 12
        let time = arc4random_uniform(B - A + 1) + A
        super.init(templateFile: "Chicken", timeBetweenEggs: Float(time), eggTexture: SKTexture(imageNamed: "white_egg"), eggValue: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
