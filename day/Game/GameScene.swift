//
//  GameScene.swift
//  day
//
//  Created by Benjamin Stammen on 10/25/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var scoreLabel : SKLabelNode?
    private var nextBirdLabel : SKLabelNode?
    private var score : Int = 0
    private var nextBirdTime : Float = 10.0
    private var spinnyNode : SKShapeNode?
    var selectedNode = SKSpriteNode()
    
    // Booleans
    private var gameInitialized : Bool = false
    // Collections
    private var birdList : Array<BirdSprite> = []
    private var cellList : Array<SKNode> = []
    
    override func sceneDidLoad() {

        if (!self.gameInitialized) {
            self.lastUpdateTime = 0
            
            // Initialize score label
            self.scoreLabel = self.childNode(withName: "//score_label") as? SKLabelNode
            
            
            // Initialize bird label
            self.nextBirdLabel = self.childNode(withName: "//next_bird_label") as? SKLabelNode
            
            self.updateLabels()
            self.initializeGame()
            /*// Create shape node to use during mouse interaction
             let w = (self.size.width + self.size.height) * 0.05
             self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
             
             if let spinnyNode = self.spinnyNode {
             spinnyNode.lineWidth = 2.5
             
             spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
             spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
             SKAction.fadeOut(withDuration: 0.5),
             SKAction.removeFromParent()]))
             }*/
            self.gameInitialized = true
        }
    }
    
    func initializeGame() {
        // add all cells to a list
        for index in 1...9 {
            self.cellList.append(self.childNode(withName: "//location_\(index)")!)
        }
        
        // shuffle the cells and then add birds to them
        self.cellList.shuffle()
        for index in 0...2 {
            let birdSprite = ChickenSprite()
            self.cellList[index].addChild(birdSprite)
            self.birdList.append(birdSprite)
        }
    }
    
    func degToRad(degree: Double) -> CGFloat {
        return CGFloat(Double(degree) / 180.0 * M_PI)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let positionInScene = touch?.location(in: self)
        selectNodeForTouch(touchLocation: positionInScene!)
    }

    
    func selectNodeForTouch(touchLocation: CGPoint) {
        let touchedNode = self.atPoint(touchLocation)
        if touchedNode is BirdSprite {
            if !selectedNode.isEqual(touchedNode) {
                selectedNode.removeAllActions()
                selectedNode = touchedNode as! SKSpriteNode
                let sequence = SKAction.sequence([SKAction.rotate(byAngle: degToRad(degree: 0.0), duration: 0.1),
                        SKAction.rotate(byAngle: degToRad(degree: -4.0), duration: 0.1),
                        SKAction.rotate(byAngle: degToRad(degree: 4.0), duration: 0.1)])
                selectedNode.run(SKAction.repeatForever(sequence))
                
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchesMoved(toPoint: t.location(in: self)) }
        let touch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
        panForTranslation(translation: translation)
    }
    
    func panForTranslation(translation: CGPoint) {
        let position = selectedNode.position
        selectedNode.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
    }
    
/*    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    

    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    

    

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }*/
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
        
        self.updateGame(deltaTime: Float(dt))
    }
    
    // called to update timers and actions in game apart from gamekit entities
    func updateGame(deltaTime: Float) {
        nextBirdTime = nextBirdTime - deltaTime;
        if (nextBirdTime <= 0) {
            nextBirdTime = 10.0
            self.addBird();
        }
        
        self.updateLabels()
    }
    
    // Adds a new bird to an open position on the grid, dismissing an older bird if necessary
    func addBird() {
        
    }
    
    func updateLabels() {
        
        if let label = self.scoreLabel {
            label.text = "Score: \(self.score)"
        }
        
        if let label = self.nextBirdLabel {
            label.text = "Next Bird Arrives In: "  + String(format: "%.0f", self.nextBirdTime)
        }
    }
    
    
}

