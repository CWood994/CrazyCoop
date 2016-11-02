//
//  LoginViewController.swift
//  day
//
//  Created by Benjamin Stammen on 10/25/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView


class LoginViewController: UIViewController,UITextFieldDelegate {
    
    var signingUp =  false
    var menuViewController: MenuViewController?
    var eulaViewController: EULAViewController?
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var signupText: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        usernameField.delegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden=true

        
        if(1 != UserDefaults.standard.object(forKey:"ACCEPTED_EULA_BIRD") as? Int){
            eulaViewController = EULAViewController.init()
            self.present(eulaViewController!, animated: true, completion: nil)
        }

        if let user = FIRAuth.auth()?.currentUser {
            activityIndicatorView.isHidden=false
            self.signedIn(user)
        }else{
            emailField.isHidden=false
            passwordField.isHidden=false
            signinButton.isHidden=false
            forgotPassButton.isHidden=false
            signupText.isHidden=false
            signupButton.isHidden=false
        }
    }
    
    @IBAction func didTapSignIn(_ sender: AnyObject) {
        // Sign In with credentials.
        guard let email = emailField.text, let password = passwordField.text else { return }
        
        if(signingUp==false){
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.notifyWithText(title: "Error:" ,text: "Invalid username / password")
                print(error.localizedDescription)
                return
            }
            self.signedIn(user!)
        }
        }else{
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.notifyWithText(title: "Error:" ,text: "Email already registered")
                print(error.localizedDescription)
                return
            }
            let ref = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()?.currentUser?.uid
            
            ref.child("users").child(userID!).child("coins").setValue(0)
            ref.child("users").child(userID!).child("streak").setValue(0)
            ref.child("users").child(userID!).child("highscore").setValue(0)
            ref.child("users").child(userID!).child("gamesPlayed").setValue(0)
            ref.child("users").child(userID!).child("username").setValue(self.usernameField.text)

            
            self.setDisplayName(user!)
        }
        }
    }
    @IBAction func didTapSignUp(_ sender: AnyObject) {
        if(signingUp==false){
            signingUp=true
            signupButton.setTitle("Login now.", for: UIControlState.normal)
            signupText.text = "Already a member?"
            usernameField.isHidden=false
            signinButton.setTitle("Sign Up", for: UIControlState.normal)
        }else{
            signingUp=false
            signupButton.setTitle("Sign up now.", for: UIControlState.normal)
            signupText.text = "Feeling left out?"
            usernameField.isHidden=true
            signinButton.setTitle("Sign In", for: UIControlState.normal)

        }
            }
    
    func setDisplayName(_ user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.components(separatedBy: "@")[0]
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedIn(FIRAuth.auth()?.currentUser)
        }
    }
    
    @IBAction func didRequestPasswordReset(_ sender: AnyObject) {
        let prompt = UIAlertController.init(title: nil, message: "Email:", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            FIRAuth.auth()?.sendPasswordReset(withEmail: userInput!) { (error) in
                if let error = error {
                    self.notifyWithText(title: "Error:" ,text: "Email not registered")
                    print(error.localizedDescription)
                    return
                }
            }
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil);
    }
    
    func signedIn(_ user: FIRUser?) {
        activityIndicatorView.isHidden=false;
        FirebaseHelper.getData(temp: self) //this is so stupid, why am i doing this lol. hacked together
        
    }
    
    func launchMenu(){ //this is called from FireBaseHelper getData
        activityIndicatorView.isHidden=true
        menuViewController = MenuViewController.init()
        self.navigationController?.pushViewController(menuViewController!, animated: false)
        if(signingUp) {didTapSignUp(self)}
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func notifyWithText(title: String, text: String){
        let prompt = UIAlertController.init(title: "Error", message: text, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default) { (action) in
           return
        }
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil);
    }
}
