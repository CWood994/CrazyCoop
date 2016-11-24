//
//  dayTests.swift
//  dayTests
//
//  Created by Benjamin Stammen on 10/25/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import XCTest
import Firebase
@testable import day

class dayTests: XCTestCase {
    var gameScene: GameScene?
    var chickenNode: ChickenNode?

    
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testLogin() {
        let asyncExpectation = expectation(description: "longRunningFunction")
        
        FIRAuth.auth()?.signIn(withEmail: "testing@osu.edu", password: "testing") { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            asyncExpectation.fulfill()
        }
        
        asyncExpectation.fulfill()
        self.waitForExpectations(timeout: 10) { error in
            print("error")
        }
        
        XCTAssert(true)
    }
    
    func testGameConversion(){
        gameScene = GameScene.init()
        XCTAssert( gameScene?.degToRad(degree: 180) == CGFloat.pi)

    }
  
    func testGameUpdateTime(){
        gameScene = GameScene.init()
        XCTAssert(gameScene?.lastUpdateTime==0)
        gameScene?.update(2)
        XCTAssert(gameScene?.lastUpdateTime==2)
    }
    
    func testGameMenuOnStart(){
        gameScene = GameScene.init()
        XCTAssert(!(gameScene?.showingMenu)!)
    }
 
    func testGameAddStrike(){
        gameScene = GameScene.init()
        XCTAssert(gameScene?.strikes == 0)
        gameScene?.addStrike()
        XCTAssert(gameScene?.strikes == 1)

    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            self.chickenNode = ChickenNode.init()
        }
    }
    
}
