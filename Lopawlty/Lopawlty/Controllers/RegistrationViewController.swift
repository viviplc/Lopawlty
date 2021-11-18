//
//  RegistrationViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/11/21.
//

import UIKit

class RegistrationViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var BtnCreateAccount: UIButton!
    @IBOutlet weak var TxtFullName: UITextField!
    @IBOutlet weak var TxtEmail: UITextField!
    @IBOutlet weak var TxtPassword: UITextField!
    @IBOutlet weak var SelectorPetType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BtnCreateAccount.layer.cornerRadius = 15
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
        
        print(newUser.firebaseDictionary)
        */
                
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
