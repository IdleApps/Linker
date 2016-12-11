//
//  RegisterViewController.swift
//  Linker
//
//  Created by Luke Cheskin on 05/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet var emailTextField: ShakingTextField!
    @IBOutlet var passwordTextField: ShakingTextField!
    @IBOutlet var confirmPasswordTextField: ShakingTextField!
    @IBOutlet var registerAccountButton: ShakingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func registerAction(_ sender: Any) {
        if passwordTextField.text! != confirmPasswordTextField.text! {
            // The passwords don't match up correctly
            print("Error: The passwords don't match up correctly")
            registerAccountButton.shakeButton()
        } else {
            // The passwords are the same
            self.signUp(email: emailTextField.text! + "@linkeruser.com", password: passwordTextField.text!)
        }
    }
    
    @IBAction func closePopup(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func runStep2Process() {
        present(self.storyboard!.instantiateViewController(withIdentifier: "RegisterInfoViewController") as UIViewController, animated: true, completion: nil)
    }
    
    func signUp(email: String, password: String) {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                // An error has occured
                print(error!)
                self.registerAccountButton.shakeButton()
            } else {
                // Successfully creating user...
                var userID: String!
                userID = FIRAuth.auth()?.currentUser?.uid
                print("User successfully created an account. User ID: " + userID)
                self.closePopup(self)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "RegisterInfo") as UIViewController
                UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
            }
        })
    }
    
}
