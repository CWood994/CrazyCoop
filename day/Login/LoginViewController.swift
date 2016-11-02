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


class LoginViewController: UIViewController {
    
    var menuViewController: MenuViewController?;
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var signupText: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden=true


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
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedIn(user!)
        }
    }
    @IBAction func didTapSignUp(_ sender: AnyObject) {
        guard let email = emailField.text, let password = passwordField.text else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.setDisplayName(user!)
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
    }
}
