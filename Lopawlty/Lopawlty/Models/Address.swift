//
//  Address.swift
//  Lopawlty
//
//  Created by user194247 on 12/2/21.
//

import Foundation

class Address {
    var street: String
    var complementaryInfo : String
    var postalCode : String
   
    init(street: String, complementaryInfo : String, postalCode : String) {
        self.street = street
        self.complementaryInfo = complementaryInfo
        self.postalCode = postalCode
    }
    

    convenience init(firebaseDictionary : [String: Any]) {
        let street = firebaseDictionary["street"] as! String? ?? ""
        let complementaryInfo = firebaseDictionary["complementaryInfo"] as! String? ?? ""
        let postalCode = firebaseDictionary["postalCode"] as! String? ?? ""
        
        self.init(street: street, complementaryInfo : complementaryInfo, postalCode : postalCode)
    }
    
    convenience init() {
        self.init(street: "", complementaryInfo : "", postalCode : "")
    }
    
    var firebaseDictionary : [String: Any] {
        return ["street" : street, "complementaryInfo" : complementaryInfo, "postalCode" : postalCode]
    }
    
}
