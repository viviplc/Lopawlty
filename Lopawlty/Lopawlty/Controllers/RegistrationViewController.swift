//
//  RegistrationViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/11/21.
//

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
    
    @IBAction func CreateAccount_Click(_ sender: Any) {
        //Create a customer
        //Read customer input
        guard let fullname = TxtFullName.text else {
            print("Error with fullname")
            return
        }
        
        guard let email = TxtEmail.text else {
            print("Error with email")
            return
        }
        
        guard let password = TxtPassword.text else {
            print("Error with password")
            return
        }
        
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
         
        // register()
        
       // print(newUser.firebaseDictionary)
        register(newCustomer: newUser)
        //register(name: fullname, email: email, password: password, petType: String(petTypeIndex), province: "Toronto", address: "Waterloo 1234");
                
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
                
            }            /*
            let request = Customer.fetchRequest() as NSFetchRequest<Customer>
            let pred = NSPredicate(format: "email = %@",email)
            request.predicate = pred
            let user = try managedContext.fetch(request)
                if (user.count == 0){
                    let customer = Customer(context: managedContext)
                
                    UserDefaults.standard.set(email, forKey: "LoggedInEmail")
                    //ProvinceSelection
                    performSegue(withIdentifier: "showProvinceSelector", sender: nil)
                    print("SUCCESS!");
                } else {
                    print("Error. Email already exists.");
                }
                       */
                   } catch{
                       print("Error during saving data : \(error)")
                   }
        
    }
 
    
    
    @objc func DismissKeyboard(){
    //Causes the view to resign from the status of first responder.
    view.endEditing(true)
    }
    

}
