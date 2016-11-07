//
//  EggIndicatorNode.swift
//  day
//
//  Created by Benjamin Stammen on 11/6/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class EggIndicatorNode : SKSpriteNode {
    
    init() {
        super.init(texture: nil, color: UIColor.clear, size: CGSize.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
