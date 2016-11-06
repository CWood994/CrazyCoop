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
    var selectedNode: SKSpriteNode?
    
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
        if touchedNode is BirdSprite {
            selectedNode?.removeAllActions()
            selectedNode = touchedNode as? SKSpriteNode
            let sequence = SKAction.sequence([SKAction.rotate(byAngle: degToRad(degree: 0.0), duration: 0.1),
                    SKAction.rotate(byAngle: degToRad(degree: -4.0), duration: 0.1),
                    SKAction.rotate(byAngle: degToRad(degree: 4.0), duration: 0.1)])
            selectedNode?.run(SKAction.repeatForever(sequence))
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
        let position = selectedNode?.position
        selectedNode?.position = CGPoint(x: (position?.x)! + translation.x, y: (position?.y)! + translation.y)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(selectedNode != nil){
            let oldParent = selectedNode?.parent
            let newParent = getNearestCell(position: (selectedNode?.position)!)
            let switchBird = newParent.childNode(withName: "bird")
            selectedNode?.position = CGPoint.zero
            selectedNode?.removeAllActions()
            selectedNode?.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))

            selectedNode?.removeFromParent()
            
            newParent.addChild(selectedNode!)
            
            if(switchBird != nil){
                switchBird?.removeFromParent()
                oldParent?.addChild(switchBird!)
            }
            
            selectedNode = nil
        }
        
    }
    func getNearestCell(position: CGPoint) -> SKNode{
        var closest: SKNode = cellList.first!
        var minDistance = Float.infinity
        var distance: Float
        for node in cellList {
            
            //distance = CGFloat(hypotf(Float(position.x.subtracting(self.convert(node.position, from: node).x)), Float(position.y.subtracting(self.convert(node.position, from: node).y))))
            
            
            
            distance = hypotf(Float(self.convert(position, from: (selectedNode?.parent!)!).x - node.position.x),
                              Float(self.convert(position, from: (selectedNode?.parent!)!).y - node.position.y))
            
            if (distance < minDistance) {
                closest = node
                minDistance = distance
            }
        }
        return closest
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
        
        for bird in self.birdList {
            bird.updateBird(deltaTime: deltaTime)
        }
        
        self.updateLabels()
    }
    
    // Adds a new bird to an open position on the grid, dismissing an older bird if necessary
    func addBird() {
        
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

