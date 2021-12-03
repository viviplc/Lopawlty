//
//  Sale.swift
//  Lopawlty
//
//  Created by user194247 on 12/2/21.
//

import Foundation

class Sale {
    var productCodes : [Int]
    var productQuantities : [Int]
    var totalItems : Int
    var customerId : String
    var delivery : Delivery
    var payment : Payment
    var creditCard : CreditCard
    
    init(productCodes : [Int], productQuantities : [Int], customerId : String, totalItems : Int) {
        self.productCodes = productCodes
        self.customerId = customerId
        self.totalItems = totalItems
        self.delivery = Delivery()
        self.payment = Payment()
        self.creditCard = CreditCard()
        self.productQuantities = productQuantities
    }
    
    var firebaseDictionary : [String: Any] {
        return ["productCodes" : productCodes, "productQuantities" : productQuantities , "totalItems" : totalItems, "customerId" : customerId]
    }
}
