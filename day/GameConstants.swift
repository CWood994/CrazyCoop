//
//  GameConstants.swift
//  day
//
//  Created by Benjamin Stammen on 11/6/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import Foundation

struct GameConstants {
    struct PhysicsConstants {
        static let EggPhysicsLayer : UInt32 = 0x1 << 1
        static let BirdPhysicsLayer: UInt32 = 0x1 << 2
        static let GoalPhysicsLayer: UInt32 = 0x1 << 3
    }
    struct LayerConstants {
        static let BackgroundLayer: CGFloat = 0;
        static let CharacterLayer: CGFloat = 5;
        static let SpecialCharacterLayer : CGFloat = 7;
        static let UILayer: CGFloat = 10;
    }
}
