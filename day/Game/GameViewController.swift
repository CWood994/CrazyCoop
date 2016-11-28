//
//  GameViewController.swift
//  day
//
//  Created by Benjamin Stammen on 10/25/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    //var skView: SKView!
    //var pauseMenu: PauseButtonNode!
    
    override func loadView() {
        //skView = SKView(frame: UIScreen.main.bounds)
        //self.view = skView
        self.view = SKView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                sceneNode.viewController = self

                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    //view.showsFPS = true
                    //view.showsNodeCount = true
                    //view.showsPhysics = true
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if(motion == UIEventSubtype.motionShake){
            if let skView = self.view as! SKView? {
                if let gameScene = skView.scene as! GameScene? {
                    gameScene.showMenu()
                }
            }
        }
    }
    
    func AddNewGameToFirebase(score: Int, streak: Int){
        if( FirebaseHelper.streak < streak){
            FirebaseHelper.streak = streak
        }
        if( FirebaseHelper.highscore < score){
            FirebaseHelper.highscore = score
        }
        FirebaseHelper.coins += score
        FirebaseHelper.gamesPlayed = FirebaseHelper.gamesPlayed + 1
        FirebaseHelper.setData()
    }
    
    func exitGame(){
        // not really necessary to pause the scene if we're just removing the view anyway, I think.
        //skView.scene?.view?.isPaused = true
        if let skView = self.view as! SKView? {
            skView.isPaused = true
        }
        self.navigationController?.popViewController(animated: true);
    }
    
    func restartGame() {
        self.viewDidLoad()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
        /*if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
