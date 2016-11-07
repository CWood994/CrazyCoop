//
//  PauseSceneNode.swift
//  day
//
//  Created by Benjamin Stammen on 11/7/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class PauseSceneNode : SKNode {

    private var gameScene: GameScene
    
    init(gameScene: GameScene) {
        self.gameScene = gameScene
        let importedScene = SKScene(fileNamed: "PauseScene")
        let containerNode: SKNode = importedScene!.childNode(withName: "//container")!
        super.init()
        
        for child in containerNode.children {
            child.removeFromParent()
            self.addChild(child)
        }
        self.isUserInteractionEnabled = true
        self.zPosition = GameConstants.LayerConstants.UILayer
        
        let menuButton = self.childNode(withName: "//menu_button") as! MenuButtonNode
        menuButton.gameScene = self.gameScene
        let restartButton = self.childNode(withName: "//restart_button") as! RestartButtonNode
        restartButton.gameScene = self.gameScene
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
