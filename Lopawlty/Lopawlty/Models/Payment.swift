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
    
    var firebaseDictionary : [String: Any] {
        return ["subTotal" : subTotal, "taxes" : taxes , "totalCost" : totalCost]
    }
    
}
