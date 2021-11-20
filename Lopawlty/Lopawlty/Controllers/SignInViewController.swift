//
//  SignInViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/11/21.
//

import UIKit
import CoreData


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
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
          }
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
        let request = Customer.fetchRequest() as NSFetchRequest<Customer>
        let pred = NSPredicate(format: "email = %@ AND password = %@",email, password)
        request.predicate = pred
        let user = try managedContext.fetch(request)
            if (user.count == 1){
                signedInCustomer = user[0]
                print("\(signedInCustomer.name) signed in")
                UserDefaults.standard.set(email, forKey: "LoggedInEmail")
                performSegue(withIdentifier: "SignInToProducts", sender: nil)
            } else {
                print("Problem signing in. Check email and password.");
            }
        } catch {
            print("Error while signing in")
        }
        }
        
    @objc func DismissKeyboard(){
    //Causes the view to resign from the status of first responder.
    view.endEditing(true)
    }
}
