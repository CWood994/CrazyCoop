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
        debugPrint("Button Initialized")
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    var gamePaused: Bool = false
    
    override func buttonSeleted() {
        self.run(SKAction.scale(to: 1.5, duration: 0.05))
    }
    
    override func buttonDeselected() {
        self.run(SKAction.scale(to: 2, duration: 0.05))
    }
    
    override func buttonPressed() {
        debugPrint("Pause the game!");
    }
}
