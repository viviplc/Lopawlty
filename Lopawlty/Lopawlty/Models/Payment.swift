//
//  Payment.swift
//  Lopawlty
//
//  Created by Viviana Leyva on 12/2/21.
//

/**
 This class is the model for a Payment which is a single payment calculation object attached to a Sale object. It provides the functionality to initialize using a Firebase Collection Dictionary, to get get payment data as well as convert from a Payment object to a Firebase collection dictionary.
 */
import Foundation

class Payment {
    var subTotal : Double
    var taxes : Double
    var totalCost : Double
    
    init(subTotal: Double, taxes : Double, totalCost : Double) {
        self.subTotal = subTotal
        self.taxes = taxes
        self.totalCost = totalCost
    }
    
    convenience init() {
        self.init(subTotal: 0.0, taxes : 0.0, totalCost : 0.0)
    }
    
    //a convenience constructor that takes a firebase dictionary. This is used when we have a firebase object of data and want to convert it to this class
    convenience init(firebaseDictionary : [String: Any]) {
        let subTotal = firebaseDictionary["subTotal"] as! Double? ?? 0.0
        let taxes = firebaseDictionary["taxes"] as! Double? ?? 0.0
        let totalCost = firebaseDictionary["totalCost"] as! Double? ?? 0.0
        
        self.init(subTotal : subTotal, taxes : taxes, totalCost : totalCost)
    }
    
    //function that takes the current instance of the class and gives out a dictionary in the [String: Any] format the firebase uses
    var firebaseDictionary : [String: Any] {
        return ["subTotal" : subTotal, "taxes" : taxes , "totalCost" : totalCost]
    }
    
    
    
}
