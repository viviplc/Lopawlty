//
//  Address.swift
//  Lopawlty
//
//  Created by Viviana Leyva on 12/2/21.
//

/**
 This class is the model for a Address which is a single address for a delivery attached to a Sale object. It provides the functionality to initialize using a Firebase Collection Dictionary, to get get delivery data as well as convert from a Delivery object to a Firebase collection dictionary.
 */

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
    
    //a convenience constructor that takes a firebase dictionary. This is used when we have a firebase object of data and want to convert it to this class
    convenience init(firebaseDictionary : [String: Any]) {
        let street = firebaseDictionary["street"] as! String? ?? ""
        let complementaryInfo = firebaseDictionary["complementaryInfo"] as! String? ?? ""
        let postalCode = firebaseDictionary["postalCode"] as! String? ?? ""
        
        self.init(street: street, complementaryInfo : complementaryInfo, postalCode : postalCode)
    }
    
    convenience init() {
        self.init(street: "", complementaryInfo : "", postalCode : "")
    }
    
    //function that takes the current instance of the class and gives out a dictionary in the [String: Any] format the firebase uses
    var firebaseDictionary : [String: Any] {
        return ["street" : street, "complementaryInfo" : complementaryInfo, "postalCode" : postalCode]
    }
    
}
