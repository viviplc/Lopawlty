//
//  RegistrationViewController.swift
//  Lopawlty
//
//  Created by Dunumalage Romeno Fernando on 11/11/21.
//

/*
 This class is the view controller for the registration view, which includes validation and integration to firebase to store data in the database (firestore)
 **/

import UIKit
import CoreData
import Firebase


class RegistrationViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var BtnCreateAccount: UIButton!
    @IBOutlet weak var TxtFullName: UITextField!
    @IBOutlet weak var TxtEmail: UITextField!
    @IBOutlet weak var TxtPassword: UITextField!
    @IBOutlet weak var SelectorPetType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BtnCreateAccount.layer.cornerRadius = 15
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
       
    }
    
    //function that validates info in the form on the view and present the errors if there are any in a UIAlertView
    func validateSignUpDetails() -> Bool {
        var validated = true
        var errorMessage = ""
        if(!Utils.validateTextFieldWithMinLen(txtLabel: TxtFullName, min: 5)) {
            validated = false
            errorMessage += "Error with Full Name (min length 5). "
        }
        
        if(!Utils.validateTextFieldWithMinLen(txtLabel: TxtEmail, min: 5)) {
            validated = false
            errorMessage += "Error with Email (min length 5). "
        }
        
        if(!Utils.validateTextFieldWithMinMaxLen(txtLabel: TxtPassword, min: 5, max: 15)) {
            validated = false
            errorMessage += "Error with Password (length 5-15). "
        }
        
        if(SelectorPetType.selectedSegmentIndex < 0) {
            validated = false
            errorMessage += "Select a pet type. "
        }
        
        if(!validated) {
            Utils.alert(message: errorMessage, viewController: self)
        }
        
        return validated
    }
    
    @IBAction func CreateAccount_Click(_ sender: Any) {
        //Create a customer
        //Read customer input
        
        if(validateSignUpDetails()) {
            let fullname = TxtFullName.text!
             
             let email = TxtEmail.text!
             
             let password = TxtPassword.text!
             
             let petTypeIndex = SelectorPetType.selectedSegmentIndex
             var petType : Pet
             switch petTypeIndex{
                 case 0:
                     petType = Pet.dog
                     break
                 case 1:
                     petType = Pet.cat
                     break
                 default:
                     petType = Pet.dog
                     break

             }
             
             let newUser = Customer(fullName: fullname, email: email, password: password, petType: petType);
              
             register(newCustomer: newUser)
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func register(newCustomer: Customer) {
       
        do{
            let db = Firestore.firestore()
            db.collection("Customers").whereField("email", isEqualTo: newCustomer.email).limit(to: 1).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error: \(err)")
                } else {
                    if let account = querySnapshot?.documents, !account.isEmpty {
                        print("email already exists!!")
                    } else {
                        // email not found in firebase
                        let ref = db.collection("Customers").document()
                        let newId = ref.documentID
                        
                        let firebaseNewCustomerDict = newCustomer.firebaseDictionary;
                        db.collection("Customers").document(newId).setData( firebaseNewCustomerDict){ err in
                            if let err = err {
                                print("error adding customer: \(err)")
                            } else {
                                print("saved new customer with id \(newId)")
                                UserDefaults.standard.set(newId, forKey: "LoggedInCustomerId")
                                //ProvinceSelection
                                self.performSegue(withIdentifier: "showProvinceSelector", sender: nil)
                            }
                        }
                    }
                }
                
            }
                   } catch{
                       print("Error during saving data : \(error)")
                   }
        
    }
 
    
    
    @objc func DismissKeyboard(){
    //Causes the view to resign from the status of first responder.
    view.endEditing(true)
    }
    

}
