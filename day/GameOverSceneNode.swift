//
//  GameOverSceneNode.swift
//  day
//
//  Created by Benjamin Stammen on 11/7/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class GameOverSceneNode : SKNode {

    init(gameScene: GameScene) {
        let importedScene = SKScene(fileNamed: "GameOverScene")
        let containerNode: SKNode = importedScene!.childNode(withName: "//container")!
        super.init()
        
        for child in containerNode.children {
            child.removeFromParent()
            self.addChild(child)
        }
        self.isUserInteractionEnabled = true
        self.zPosition = GameConstants.LayerConstants.UILayer
        
        let menuButton = self.childNode(withName: "//menu_button") as! MenuButtonNode
        menuButton.gameScene = gameScene
        let restartButton = self.childNode(withName: "//restart_button") as! RestartButtonNode
        restartButton.gameScene = gameScene
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setScoreLabel(score: Int) {
        let scoreLabel = self.childNode(withName: "//score_label") as! SKLabelNode
        scoreLabel.text = "\(score)"
    }
}
