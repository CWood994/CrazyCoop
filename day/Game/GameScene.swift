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
    var viewController: GameViewController!

    // Game Entities
    private var strikesLabel : SKLabelNode?
    private var streakLabel : SKLabelNode?
    private var scoreLabel : SKLabelNode?
    private var nextBirdLabel : SKLabelNode?
    private var pauseButton : PauseButtonNode?
    private var pauseMenu : PauseSceneNode?
    private var gameOverMenu : GameOverSceneNode?
    
    // Game Attributes
    var strikes : Int = 0
    var currentStreak : Int = 0
    var maxStreak : Int = 0
    var score : Int = 0
    var lastUpdateTime : TimeInterval = 0
    private var nextBirdTime : Float = 10.0
    private var selectedNode: BirdNode?
    var showingMenu : Bool = false;
    
    // Collections
    var birdList : Array<BirdNode> = []
    private var cellList : Array<SKNode> = []

    // MARK: Game Lifecycle
    override func didMove(to view: SKView) {
        self.lastUpdateTime = 0
        
        self.strikesLabel = self.childNode(withName: "//strikes_label") as? SKLabelNode
        self.streakLabel = self.childNode(withName: "//streak_label") as? SKLabelNode
        self.scoreLabel = self.childNode(withName: "//score_label") as? SKLabelNode
        self.nextBirdLabel = self.childNode(withName: "//next_bird_label") as? SKLabelNode
        self.pauseButton = self.childNode(withName: "//pause_button") as? PauseButtonNode
        self.pauseButton?.gameScene = self
        self.pauseMenu = PauseSceneNode(gameScene: self)
        self.gameOverMenu = GameOverSceneNode(gameScene: self)
        
        self.updateLabels()
        self.initializeGame()
    }

    
    func initializeGame() {
        self.birdList = []
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
        
        self.createGoal()
        
        self.physicsWorld.contactDelegate = self
    }
    
    func createGoal() {
        let goalNode = self.childNode(withName: "//goal_sprite")
        let physicsBody = SKPhysicsBody(edgeLoopFrom: (goalNode?.frame)!)
        physicsBody.fieldBitMask = GameConstants.PhysicsConstants.GoalPhysicsLayer
        physicsBody.categoryBitMask = GameConstants.PhysicsConstants.GoalPhysicsLayer
        physicsBody.contactTestBitMask = GameConstants.PhysicsConstants.EggPhysicsLayer
        physicsBody.collisionBitMask = 0
        goalNode?.physicsBody = physicsBody
    }
    
    func showMenu() {
        self.showingMenu = true
        self.physicsWorld.speed = 0.0
        
        // start transitions
        let menuSprite = self.pauseMenu?.childNode(withName: "//menu_sprite")
        let darkSprite = self.pauseMenu?.childNode(withName: "//dark_sprite")
        
        menuSprite?.position = CGPoint(x: 0, y: self.frame.height/2 + (menuSprite?.frame.height)!/2)
        let presentMenu = SKAction.move(to: CGPoint.zero, duration: 0.2)
        menuSprite?.run(presentMenu)
        
        darkSprite?.alpha = 0
        darkSprite?.run(SKAction.fadeIn(withDuration: 0.1))
        
        self.addChild(self.pauseMenu!)
    }
    
    func hideMenu() {
        debugPrint("hiding menu...")
        self.showingMenu = false
        self.physicsWorld.speed = 1.0
        self.pauseMenu?.removeFromParent()
    }
    
    func endGame() {
        self.viewController.AddNewGameToFirebase(score: self.score, streak: self.maxStreak)
        self.pauseButton?.removeFromParent()
        self.physicsWorld.speed = 0.0
        self.showingMenu = true
        self.gameOverMenu?.setScoreLabel(score: self.score)
        self.addChild(self.gameOverMenu!)
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
            let birdNode = touchedNode as! BirdNode
            
            birdNode.removeAllActions()
            selectedNode = birdNode
            selectedNode?.zPosition = GameConstants.LayerConstants.SpecialCharacterLayer
            let sequence = SKAction.sequence([SKAction.rotate(byAngle: degToRad(degree: 0.0), duration: 0.1),
                    SKAction.rotate(byAngle: degToRad(degree: -4.0), duration: 0.1),
                    SKAction.rotate(byAngle: degToRad(degree: 4.0), duration: 0.1)])
            birdNode.run(SKAction.repeatForever(sequence))
            birdNode.startFlutterAction(withParticles: true)
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
        if (selectedNode != nil) {
            let position = selectedNode?.position
            selectedNode?.position = CGPoint(x: (position?.x)! + translation.x, y: (position?.y)! + translation.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(selectedNode != nil){
            let oldParent = selectedNode?.parent
            let newParent = getNearestCell(position: (selectedNode?.position)!)
            let switchBird = newParent.childNode(withName: "bird")
            selectedNode?.position = CGPoint.zero
            selectedNode?.removeAllActions()
            selectedNode?.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
            selectedNode?.startIdleAction()
            selectedNode?.removeFromParent()
            
            newParent.addChild(selectedNode!)
            selectedNode?.zPosition = GameConstants.LayerConstants.CharacterLayer
            
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

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        if (!self.showingMenu) {
            // Update entities
            for entity in self.entities {
                entity.update(deltaTime: dt)
            }
            
            self.updateGame(deltaTime: Float(dt))
        }
        
        self.lastUpdateTime = currentTime
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
            self.cellList.shuffle()
            // just search for the empty grid spot
            for index in 0...self.cellList.count {
                if (self.cellList[index].children.count == 0) {
                    self.cellList[index].addChild(bird)
                    break
                }
            }
        } else {
            // find the oldest bird and make it fly away
            let oldBird = birdList[0]
            let cell = oldBird.parent
            self.removeBirdFromGame(birdToRemove: oldBird)
            
            // add a new bird to its cell
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
        
        // If the bird is the currently selected node, set selectedNode to nil
        if (selectedNode?.parent == birdToRemove.parent) {
            selectedNode = nil
        }
        
        let convertedLocation = self.convert(birdToRemove.position, from: birdToRemove.parent!)
        birdToRemove.removeFromParent()
        birdToRemove.position = convertedLocation
        self.addChild(birdToRemove)
        //birdToRemove.run(SKAction(named: "move_off_left"), com)
        birdToRemove.startFlutterAction(withParticles: false)
        birdToRemove.run(SKAction(named: "move_off_left")!, completion: {
            
        })
    }
    
    // Adds a strike, and ends the game if necessary
    func addStrike() {
        self.strikes += 1
        if (self.currentStreak > self.maxStreak) {
            self.maxStreak = self.currentStreak
        }
        self.currentStreak = 0
        if (self.strikes >= 3) {
            self.endGame()
        }
    }
    
    func updateLabels() {
        
        if let label = self.strikesLabel {
            label.text = "Strikes: \(self.strikes)"
        }
        
        if let label = self.streakLabel {
            label.text = "Streak: \(self.currentStreak)"
        }
        
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
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch (contactMask) {
        case GameConstants.PhysicsConstants.BirdPhysicsLayer:
            debugPrint("Two birds collided.")
            self.handleBirdBirdCollision(firstBird: contact.bodyA.node as! BirdNode, secondBird: contact.bodyB.node as! BirdNode)
        case GameConstants.PhysicsConstants.EggPhysicsLayer | GameConstants.PhysicsConstants.BirdPhysicsLayer:
            debugPrint("Chicken and egg collided.")
            if let egg = contact.bodyA.node as? EggNode {
                self.handleEggBirdCollision(egg: egg, bird: contact.bodyB.node as! BirdNode)
            } else if let egg = contact.bodyB.node as? EggNode {
                self.handleEggBirdCollision(egg: egg, bird: contact.bodyA.node as! BirdNode)
            }
        case GameConstants.PhysicsConstants.EggPhysicsLayer | GameConstants.PhysicsConstants.GoalPhysicsLayer:
            debugPrint("Egg reached goal.")
            if let egg = contact.bodyA.node as? EggNode {
                self.handleEggGoalCollision(egg: egg)
            } else if let egg = contact.bodyB.node as? EggNode {
                self.handleEggGoalCollision(egg: egg)
            }
        default:
            print("Unknown case.")
        }
        
        self.updateLabels()
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        // If two chickens begin contact...
        if (contact.bodyA.categoryBitMask == GameConstants.PhysicsConstants.BirdPhysicsLayer &&
            contact.bodyB.categoryBitMask == GameConstants.PhysicsConstants.BirdPhysicsLayer) {
            debugPrint("Two chickens stopped colliding!")
        }
    }
    
    func handleBirdBirdCollision(firstBird: BirdNode, secondBird: BirdNode) {
        
    }
    
    func handleEggBirdCollision(egg: EggNode, bird: BirdNode) {
        if (egg.sourceBird != bird) {
            egg.removeFromParent()
            self.removeBirdFromGame(birdToRemove: bird)
            self.addStrike()
        }
    }
    
    func handleEggGoalCollision(egg: EggNode) {
        self.score += egg.value
        self.currentStreak += 1
        // we no longer have to register events with this egg
        egg.physicsBody?.contactTestBitMask = 0
        egg.physicsBody?.categoryBitMask = 0
    }
}

