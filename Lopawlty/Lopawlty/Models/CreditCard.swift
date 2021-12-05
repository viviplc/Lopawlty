//
//  CreditCard.swift
//  Lopawlty
//
//  Created by Viviana Leyva on 12/2/21.
//

/**
 This class is the model for a CreditCard which is a single credit card attached to a Sale object. It provides the functionality to initialize using a Firebase Collection Dictionary, as well as convert from a CreditCard object to a Firebase collection dictionary.
 */
import Foundation

class CreditCard {
    var cardHolderName: String
    var email : String
    var creditCardNumber : String
    var expirationDate : String
    var cvv : Int
   
    init(cardHolderName: String, email : String, creditCardNumber : String, expirationDate: String, cvv : Int) {
        self.cardHolderName = cardHolderName
        self.email = email
        self.creditCardNumber = creditCardNumber
        self.expirationDate = expirationDate
        self.cvv = cvv
    }
    
    convenience init() {
        self.init(cardHolderName: "", email : "", creditCardNumber : "", expirationDate: "", cvv : 0)
    }
    

    convenience init(firebaseDictionary : [String: Any]) {
        let cardHolderName = firebaseDictionary["cardHolderName"] as! String? ?? ""
        let email = firebaseDictionary["email"] as! String? ?? ""
        let creditCardNumber = firebaseDictionary["creditCardNumber"] as! String? ?? ""
        let expirationDate = firebaseDictionary["expirationDate"] as! String? ?? ""
        let cvv = firebaseDictionary["cvv"] as! Int? ?? 0
        
        self.init(cardHolderName: cardHolderName, email : email, creditCardNumber : creditCardNumber, expirationDate: expirationDate, cvv : cvv)
    }
    
    var firebaseDictionary : [String: Any] {
        return ["cardHolderName" : cardHolderName, "email" : email, "creditCardNumber" : creditCardNumber, "expirationDate": expirationDate, "cvv" : cvv]
    }
    
}
