//
//  Copyright (c) 2015 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Firebase

//update static vars then call setData when complete

class FirebaseHelper: NSObject {

    static var coins = -1
    static var streak = -1
    static var highscore = -1
    static var gamesPlayed = -1
    static var username = "[undefined]"
    
    static let sharedInstance = FirebaseHelper()

  static func sendLogoutEvent() {
    let firebaseAuth = FIRAuth.auth()
    do {
        try firebaseAuth?.signOut()
    } catch let signOutError as NSError {
        print ("Error signing out: \(signOutError.localizedDescription)")
    }
  }

    //only call this from login, hacked together =(
    static func getData(temp: LoginViewController){
    let ref = FIRDatabase.database().reference()
    let userID = FIRAuth.auth()?.currentUser?.uid

    ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
        let value = snapshot.value as? NSDictionary
        coins = value?["coins"] as! Int
        streak = value?["streak"] as! Int
        highscore = value?["highscore"] as! Int
        username = value?["username"] as! String
        gamesPlayed = value?["gamesPlayed"] as! Int
        
        temp.launchMenu()
        
    }) { (error) in
        print(error.localizedDescription)
    }
  }
    
    static func setData(){
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").child(userID!).child("coins").setValue(coins)
        ref.child("users").child(userID!).child("streak").setValue(streak)
        ref.child("users").child(userID!).child("highscore").setValue(highscore)
        ref.child("users").child(userID!).child("gamesPlayed").setValue(gamesPlayed)
    }
}
