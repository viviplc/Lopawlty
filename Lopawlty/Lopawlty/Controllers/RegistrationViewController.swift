//
//  RegistrationViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/11/21.
//

import UIKit
import CoreData

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
        /*var petType : Pet
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
        
        let newUser = User(fullName: fullname, email: email, password: password, petType: petType);
         
         register()
        
        print(newUser.firebaseDictionary)
        */
        register(name: fullname, email: email, password: password, petType: String(petTypeIndex), province: "Toronto", address: "Waterloo 1234");
                
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func register(name: String, email : String, password: String, petType: String, province: String, address: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
          }
          let managedContext = appDelegate.persistentContainer.viewContext
        
      
        
        do{
            let request = Customer.fetchRequest() as NSFetchRequest<Customer>
            let pred = NSPredicate(format: "email = %@",email)
            request.predicate = pred
            let user = try managedContext.fetch(request)
                if (user.count == 0){
                    let customer = Customer(context: managedContext)
                    customer.name = name;
                    customer.email = email;
                    customer.password = password;
                    customer.petType = petType;
                    customer.province = province;
                    customer.address = address;
                    try managedContext.save()
                     print("SUCCESS!");
                } else {
                    print("Error. Email already exists.");
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
