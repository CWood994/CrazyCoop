//
//  PauseSceneNode.swift
//  day
//
//  Created by Benjamin Stammen on 11/7/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class PauseSceneNode : SKNode {

    override init() {
        let importedScene = SKScene(fileNamed: "PauseScene")
        let containerNode: SKNode = importedScene!.childNode(withName: "//container")!
        super.init()
        
        for child in containerNode.children {
            child.removeFromParent()
            self.addChild(child)
        }
        self.isUserInteractionEnabled = true
        self.zPosition = GameConstants.LayerConstants.UILayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
