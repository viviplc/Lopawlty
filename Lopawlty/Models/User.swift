//
//  User.swift
//  Lopawlty
//
//  Created by user194247 on 11/11/21.
//

import Foundation

enum Pet : String {
    case dog, cat
}

class User {
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
    }
    
    convenience init() {
        self.init(fullName : "", email : "", password: "", petType: Pet.dog)
    }
    
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
    
    func saveData() {
        // save data to firebase
    }
    
}

