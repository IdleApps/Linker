//
//  RegisterInfoViewController.swift
//  Linker
//
//  Created by Luke Cheskin on 08/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var nameTextFields: ShakingTextField!
    @IBOutlet var birthdayTextField: ShakingTextField!
    @IBOutlet var countryTextField: ShakingTextField!
    @IBOutlet var completeRegistrationButton: ShakingButton!
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var countries: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func completeRegisterAction(_ sender: Any) {
        
        if nameTextFields.text! == "" || birthdayTextField.text! == "" || countryTextField.text! == "" {
            
            // Some of the text fields have not been filled out
            print("One or more text fields have not been filled out")
            completeRegistrationButton.shakeButton()
            
        } else {
            // All text fields have been filled out
            
            var userID: String!
            userID = FIRAuth.auth()?.currentUser?.uid
            
            var usersEmail: String!
            usersEmail = FIRAuth.auth()?.currentUser?.email
            
            let usersEmailShowable = usersEmail.replacingOccurrences(of: "@linkeruser.com", with: "", options: .literal, range: nil)
            
            let userRef = self.databaseRef.child("Users").child(usersEmailShowable)
            let userInfo = ["A-Username": usersEmailShowable, "B-Name": nameTextFields.text!, "D-Country": countryTextField.text!, "C-DOB": birthdayTextField.text!, "E-UserID": userID]
            userRef.setValue(userInfo)
            
            self.dismiss(animated: true, completion: nil)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as UIViewController
            UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
        }
        
    }
   
    @IBAction func countryTextFieldAction(_ sender: Any) {
        
        print("countryTextFieldAction")
        
        countries = NSLocale.isoCountryCodes.map { (code:String) -> String in
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            return NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        }
        
        print(countries)
        
        let countryPicker: UIPickerView = UIPickerView()
        countryTextField.inputView = countryPicker
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        
    }
        
    @IBAction func birthdayTextFieldAction(_ sender: Any) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.addTarget(self, action: #selector(RegisterInfoViewController.birthdayDatePickerValueChanged), for: UIControlEvents.valueChanged)
        birthdayTextField.inputView = datePickerView
        
    }
    
    func birthdayDatePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        birthdayTextField.text = dateFormatter.string(from: sender.date)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedValue = countries[row] as String
        countryTextField.text! = selectedValue
        
    }
    
}
