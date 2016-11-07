//
//  EggIndicatorNode.swift
//  day
//
//  Created by Benjamin Stammen on 11/6/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class EggIndicatorNode : SKSpriteNode {
    
    var bird: BirdNode
    var egg: SKSpriteNode
    
    init(bird: BirdNode) {
        self.bird = bird
        self.egg = SKSpriteNode(texture: bird.eggTexture, color: UIColor.clear, size: bird.eggTexture.size())
        
        let importedScene = SKScene(fileNamed: "EggIndicator")
        let containerNode: SKSpriteNode = importedScene!.childNode(withName: "//container") as! SKSpriteNode
        super.init(texture: nil, color: UIColor.clear, size: containerNode.size)
        containerNode.removeFromParent()
        self.addChild(containerNode)
        containerNode.childNode(withName: "egg_location")?.addChild(egg)
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // bird.layEgg() will take care of removing this object from the tree
        bird.layEgg()
    }
}
