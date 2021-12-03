//
//  Payment.swift
//  Lopawlty
//
//  Created by user194247 on 12/2/21.
//

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
    
    convenience init(firebaseDictionary : [String: Any]) {
        let subTotal = firebaseDictionary["subTotal"] as! Double? ?? 0.0
        let taxes = firebaseDictionary["taxes"] as! Double? ?? 0.0
        let totalCost = firebaseDictionary["totalCost"] as! Double? ?? 0.0
        
        self.init(subTotal : subTotal, taxes : taxes, totalCost : totalCost)
    }
    
    var firebaseDictionary : [String: Any] {
        return ["subTotal" : subTotal, "taxes" : taxes , "totalCost" : totalCost]
    }
    
    
    
}
