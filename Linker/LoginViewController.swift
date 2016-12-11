//
//  PopupViewController.swift
//  Linker
//
//  Created by Luke Cheskin on 05/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginAccountAction: ShakingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TESTING GITHUB!")
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        self.signIn(email: emailTextField.text! + "@linkeruser.com", password: passwordTextField.text!)
    }
    
    @IBAction func closePopup(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func signIn(email: String, password: String) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                // An error has occured
                print(error!)
                self.loginAccountAction.shakeButton()
            } else {
                // Successfully authenticating...
                var userID: String!
                userID = FIRAuth.auth()?.currentUser?.uid
                print("User successfully logged in. User ID: " + userID)
                
                self.databaseRef.childByAutoId()
                
            }
        })
    }
    
}
