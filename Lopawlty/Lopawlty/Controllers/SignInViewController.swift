//
//  SignInViewController.swift
//  Lopawlty
//
//  Created by Dunumalage Romeno Fernando on 11/11/21.
//

/*
 This class is the view controller for the sign in view, which includes validation and integration to firebase to store data in the database (firestore)
 **/

import UIKit
import CoreData
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var TxtEmail: UITextField!
    
    @IBOutlet weak var TxtPassword: UITextField!
    
    var signedInCustomer : Customer = Customer()
    
    @IBOutlet weak var BtnSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BtnSignIn.layer.cornerRadius = 15
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
    }
    
    func validateSignIn() -> Bool {
        var validated = true
        var errorMessage = ""
        if(!Utils.validateTextFieldWithMinLen(txtLabel: TxtEmail, min: 5)) {
            validated = false
            errorMessage += "Error with Email (min length 5). "
        }
        if(!Utils.validateTextFieldWithMinMaxLen(txtLabel: TxtPassword, min: 5, max: 15)) {
            validated = false
            errorMessage += "Error with Password (length 5-15). "
        }
        
        if(!validated) {
            Utils.alert(message: errorMessage, viewController: self)
        }
        
        return validated
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        
        if(validateSignIn()) {
            BtnSignIn.isEnabled = false
            let email = TxtEmail.text!
            let password = TxtPassword.text!
            signIn(email: email, password: password)
        }
        
        
    }
    
    
    func signIn(email : String, password : String){
        let db = Firestore.firestore()
        db.collection("Customers").whereField("email", isEqualTo: email).whereField("password", isEqualTo: password).limit(to: 1).getDocuments() { (querySnapshot, err) in
            
            self.BtnSignIn.isEnabled = true
            if let err = err {
                print("Error: \(err)")
            } else {
                if let account = querySnapshot?.documents, !account.isEmpty {
                    UserDefaults.standard.set(account[0].documentID, forKey: "LoggedInCustomerId")
                    print("user logged in -> \(account[0].data())")
                    self.performSegue(withIdentifier: "SignInToProducts", sender: nil)
                } else {
                    Utils.alert(message: "Wrong email or password.", viewController: self)
                }
            }
        }
        }
        
    @objc func DismissKeyboard(){
    //Causes the view to resign from the status of first responder.
    view.endEditing(true)
    }
}
