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
        super.init(templateFile: "Chicken", timeBetweenEggs: 10.0, eggTexture: SKTexture(imageNamed: "white_egg"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
