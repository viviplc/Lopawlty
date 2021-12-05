//
//  Customer.swift
//  Lopawlty
//
//  Created by Dunumalage Romeno Fernando on 11/30/21.
//

/**
 This class is the model for a Customer which is a single user of our app. It provides the functionality to initialize using a Firebase Collection Dictionary, to get get customer data.
 */

import Foundation
import Firebase

enum Pet : String {
    case dog, cat
}

class Customer {
    var id : String
    var fullName : String
    var email : String
    var password : String
    var petType : Pet
    var province : String
    
    init(fullName: String, email : String, password : String, petType: Pet) {
        self.fullName = fullName
        self.email = email
        self.password = password
        self.petType = petType
        self.province = ""
        self.id = ""
    }
    
    convenience init() {
        self.init(fullName : "", email : "", password: "", petType: Pet.dog)
    }
    
    //a convenience constructor that takes a firebase dictionary. This is used when we have a firebase object of data and want to convert it to this class
    convenience init(firebaseDictionary : [String: Any]) {
        let fullName = firebaseDictionary["fullName"] as! String? ?? ""
        let email = firebaseDictionary["email"] as! String? ?? ""
        let password = firebaseDictionary["password"] as! String? ?? ""
        let petString = firebaseDictionary["petType"] as! String? ?? ""
        if let petType = Pet(rawValue: petString) {
            self.init(fullName : fullName, email : email, password : password, petType : petType)
        } else {
            self.init(fullName : fullName, email : email, password : password, petType : Pet.dog)
        }
    }
    
    var firebaseDictionary : [String: Any] {
        return ["fullName" : fullName, "email" : email, "password" : password, "petType": String(describing: petType)]
    }
    
}
