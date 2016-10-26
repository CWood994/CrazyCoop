//
//  LoginViewController.swift
//  day
//
//  Created by Benjamin Stammen on 10/25/16.
//  Copyright © 2016 Benjamin Stammen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Properties
    var menuViewController: MenuViewController?;
    
    // MARK: IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // more setup
        signInButton.layer.cornerRadius = 5;
    }
    
    @IBAction func signInButtonTapped(_ sender: AnyObject) {
        // TODO: Use segues instead for God's sake
        menuViewController = MenuViewController.init()
        self.navigationController?.pushViewController(menuViewController!, animated: false)
    }
}
