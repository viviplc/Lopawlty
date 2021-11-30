//
//  SignInViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/11/21.
//

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
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        guard let email = TxtEmail.text else {
            print("Error with email")
            return
        }
        guard let password = TxtPassword.text else {
            print("Error with password")
            return
        }
        signIn(email: email, password: password)
    }
    
    
    func signIn(email : String, password : String){
        let db = Firestore.firestore()
        db.collection("Customers").whereField("email", isEqualTo: email).whereField("password", isEqualTo: password).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error: \(err)")
            } else {
                if let account = querySnapshot?.documents, !account.isEmpty {
                    UserDefaults.standard.set(account[0].documentID, forKey: "LoggedInCustomerId")
                    print("user logged in -> \(account[0].data())")
                    self.performSegue(withIdentifier: "SignInToProducts", sender: nil)
                } else {
                    print("Wrong email or password.");
                }
            }
        }
        }
        
    @objc func DismissKeyboard(){
    //Causes the view to resign from the status of first responder.
    view.endEditing(true)
    }
}
