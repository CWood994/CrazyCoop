//
//  ButtonNode.swift
//  day
//
//  Created by Benjamin Stammen on 11/7/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit

class ButtonNode : SKSpriteNode {
    
    private var selected = false
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize() {
        self.isUserInteractionEnabled = true
    }
    
    func buttonSeleted() {
        
    }
    
    func buttonDeselected() {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.selected = true
        self.buttonSeleted()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.parent!)
        
        if !self.contains(location) {
            self.selected = false
            self.buttonDeselected()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (self.selected) {
            self.selected = false
            self.buttonDeselected()
            self.buttonPressed()
        }
    }
    
    func buttonPressed() {
        debugPrint("Button press not overridden")
    }
}

class PauseButtonNode : ButtonNode {
    
    var gameScene : GameScene?
    
    override func initialize() {
        super.initialize()
        self.zPosition = GameConstants.LayerConstants.UILayer + 1
    }
    
    override func buttonSeleted() {
        self.run(SKAction.scale(to: 1.5, duration: 0.05))
    }
    
    override func buttonDeselected() {
        self.run(SKAction.scale(to: 2, duration: 0.05))
    }
    
    override func buttonPressed() {
        if let game: GameScene = self.gameScene {
            if (game.showingMenu) {
                game.hideMenu()
            } else {
                game.showMenu()
            }
        }
    }
}

class RestartButtonNode : ButtonNode {
    
    var gameScene : GameScene?
    
    override func buttonSeleted() {
        self.run(SKAction.scale(to: 0.8, duration: 0.05))
    }
    
    override func buttonDeselected() {
        self.run(SKAction.scale(to: 1, duration: 0.05))
    }
    
    override func buttonPressed() {
        if let game: GameScene = self.gameScene {
            game.viewController.restartGame()
        }
    }
}

class MenuButtonNode : ButtonNode {
    
    var gameScene : GameScene?
    
    override func buttonSeleted() {
        self.run(SKAction.scale(to: 0.8, duration: 0.05))
    }
    
    override func buttonDeselected() {
        self.run(SKAction.scale(to: 1, duration: 0.05))
    }
    
    override func buttonPressed() {
        if let game: GameScene = self.gameScene {
            //game.viewController.AddNewGameToFirebase(score:score,streak:maxStreak) //TODO: call this line when game is over only
            game.viewController.exitGame()
        }
    }
}
