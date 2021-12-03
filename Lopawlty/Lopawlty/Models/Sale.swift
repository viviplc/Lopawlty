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
    var address : Address
    
    init(productCodes : [Int], productQuantities : [Int], customerId : String, totalItems : Int) {
        self.productCodes = productCodes
        self.customerId = customerId
        self.totalItems = totalItems
        self.delivery = Delivery()
        self.payment = Payment()
        self.creditCard = CreditCard()
        self.address = Address()
        self.productQuantities = productQuantities
    }
    
    convenience init() {
        let productCodes : [Int] = []
        let productQuantities : [Int] = []
        self.init(productCodes : productCodes, productQuantities : productQuantities, customerId : "", totalItems : 0)
    }
    
    convenience init(firebaseDictionary : [String: Any]) {
        let emptyProductCodes : [Int] = []
        let emptyProductQuantities : [Int] = []
        let emptyDelivery = Delivery()
        let emptyPayment = Payment()
        let emptyCreditCard = CreditCard()
        let emptyAddress = Address()
        
        let productCodes = firebaseDictionary["productCodes"] as! [Int]? ?? emptyProductCodes
        let productQuantities = firebaseDictionary["productQuantities"] as! [Int]? ?? emptyProductQuantities
        let totalItems = firebaseDictionary["totalItems"] as! Int? ?? 0
        let totalCost = firebaseDictionary["totalCost"] as! Double? ?? 0.0
        let customerId = firebaseDictionary["customerId"] as! String? ?? ""
        
        let paymentDict = firebaseDictionary["payment"] as! [String : Any]? ?? emptyPayment.firebaseDictionary
        let payment = Payment(firebaseDictionary: paymentDict)
        
        let creditCardDict = firebaseDictionary["creditCard"] as! [String : Any]? ?? emptyCreditCard.firebaseDictionary
        let creditCard = CreditCard(firebaseDictionary: creditCardDict)
        
        let addressDict = firebaseDictionary["address"] as! [String : Any]? ?? emptyAddress.firebaseDictionary
        let address = Address(firebaseDictionary: addressDict)
        
        let deliveryDict = firebaseDictionary["delivery"] as! [String : Any]? ?? emptyDelivery.firebaseDictionary
        let delivery = Delivery(firebaseDictionary: deliveryDict)
        
        self.init(productCodes : productCodes, productQuantities : productQuantities, customerId : customerId, totalItems : totalItems)
        
        self.payment = payment
        self.creditCard = creditCard
        self.address = address
        self.delivery = delivery
    }
    
    var firebaseDictionary : [String: Any] {
        return ["productCodes" : productCodes, "productQuantities" : productQuantities , "totalItems" : totalItems, "customerId" : customerId]
    }
}
