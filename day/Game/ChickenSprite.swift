//
//  ChickenSprite.swift
//  day
//
//  Created by Benjamin Stammen on 11/5/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class ChickenSprite : BirdSprite {
    init() {
        super.init(beakTexture: SKTexture(imageNamed: "chicken_beak"),
                   bodyTexture: SKTexture(imageNamed: "chicken_body"),
                   eggTexture: SKTexture(imageNamed: "egg"),
                   timeBetweenEggs: 10.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
