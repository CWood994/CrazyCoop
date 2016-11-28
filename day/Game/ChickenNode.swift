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
        let lowerRange: UInt32 = 7
        let upperRange: UInt32 = 14
        let time = arc4random_uniform(upperRange - lowerRange + 1) + lowerRange
        super.init(templateFile: "Chicken", timeBetweenEggs: Float(time), eggTexture: SKTexture(imageNamed: "white_egg"), eggValue: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
