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
    private var nextBirdTime : Float = 10.0
    
    var selectedNode = SKSpriteNode()
    
    // Game Attributes
    private var strikes : Int = 0
    private var currentStreak : Int = 0
    private var maxStreak : Int = 0
    private var score : Int = 0
    

    
    // Collections
    private var birdList : Array<BirdNode> = []
    private var cellList : Array<SKNode> = []
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        self.lastUpdateTime = 0
        
        // Initialize score label
        self.scoreLabel = self.childNode(withName: "//score_label") as? SKLabelNode
        
        
        // Initialize bird label
        self.nextBirdLabel = self.childNode(withName: "//next_bird_label") as? SKLabelNode
        
        self.updateLabels()
        self.initializeGame()
    }
    
    func initializeGame() {
        // add all cells to a list
        for index in 1...9 {
            self.cellList.append(self.childNode(withName: "//location_\(index)")!)
        }
        
        // shuffle the cells and then add birds to them
        self.cellList.shuffle()
        for index in 0...2 {
            let birdNode = ChickenNode()
            self.cellList[index].addChild(birdNode)
            self.birdList.append(birdNode)
        }
        
        self.physicsWorld.contactDelegate = self
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
        if touchedNode is BirdNode {
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
            self.addBirdToGame();
        }
        
        for bird in self.birdList {
            bird.updateBird(deltaTime: deltaTime)
        }
        
        self.updateLabels()
    }
    
    // Adds a new bird to an open position on the grid, dismissing an older bird if necessary
    func addBirdToGame() {
        
        let bird = ChickenNode()
        
        if (birdList.count < 9) {
            // just search for the empty grid spot
            for index in 0...self.cellList.count {
                if (self.cellList[index].children.count == 0) {
                    self.cellList[index].addChild(bird)
                    break
                }
            }
        } else {
            // replace the oldest bird
            let cell = birdList[0].parent
            // TODO: maybe make it fly away
            birdList[0].removeFromParent()
            birdList.remove(at: 0)
            cell?.addChild(bird)
        }
        
        self.birdList.append(bird)
    }
    
    // Removes the passed in bird from the game by value, ensuring all precautions are taken
    func removeBirdFromGame(birdToRemove: BirdNode) {
        for index in 0...self.birdList.count {
            if (self.birdList[index].parent?.name == birdToRemove.parent?.name) {
                birdList.remove(at: index)
                break
            }
        }
        birdToRemove.removeFromParent()
    }
    
    // Adds a strike, and ends the game if necessary
    func addStrike() {
        self.strikes += 1
        updateLabels()
        if (self.strikes >= 3) {
            self.endGame()
        }
    }
    
    func endGame() {
        
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

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        // If a chicken and an egg collide...
        if (contact.bodyA.categoryBitMask == GameConstants.PhysicsConstants.BirdPhysicsLayer &&
            contact.bodyB.categoryBitMask == GameConstants.PhysicsConstants.EggPhysicsLayer) ||
           (contact.bodyA.categoryBitMask == GameConstants.PhysicsConstants.EggPhysicsLayer &&
            contact.bodyB.categoryBitMask == GameConstants.PhysicsConstants.BirdPhysicsLayer) {
            let birdNode: BirdNode?
            let eggNode:  EggNode?
            if (contact.bodyA.categoryBitMask == GameConstants.PhysicsConstants.BirdPhysicsLayer) {
                birdNode = contact.bodyA.node as! BirdNode?
                eggNode  = contact.bodyB.node as! EggNode?
            } else {
                birdNode = contact.bodyB.node as! BirdNode?
                eggNode  = contact.bodyA.node as! EggNode?
            }
            
            if (birdNode != eggNode?.sourceBird) {
                debugPrint("A chicken and egg collided!")
                eggNode?.removeFromParent()
                // tell the bird to go away, too
                self.removeBirdFromGame(birdToRemove: birdNode!)
                self.addStrike()
            }
            
            
        }
        
        // If two chickens begin contact...
        if (contact.bodyA.categoryBitMask == GameConstants.PhysicsConstants.BirdPhysicsLayer &&
            contact.bodyB.categoryBitMask == GameConstants.PhysicsConstants.BirdPhysicsLayer) {
            debugPrint("Two chickens collided!")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        // If two chickens begin contact...
        if (contact.bodyA.categoryBitMask == GameConstants.PhysicsConstants.BirdPhysicsLayer &&
            contact.bodyB.categoryBitMask == GameConstants.PhysicsConstants.BirdPhysicsLayer) {
            debugPrint("Two chickens stopped colliding!")
        }
    }
}

