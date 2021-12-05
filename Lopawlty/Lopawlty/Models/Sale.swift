//
//  Sale.swift
//  Lopawlty
//
//  Created by Dunumalage Romeno Fernando on 12/2/21.
//

/**
 This class is the model for a sale which is a single order that a customer can make. It is attached to Delivery, Payment, CreditCard, Address classes. It provides the functionality to initialize using a Firebase Collection Dictionary, to get the Product array from the Sale object etc.
 */

import Foundation
import Firebase

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
    
    //a convenience constructor that takes a firebase dictionary. This is used when we have a firebase object of data and want to convert it to this Sale class. We have to turn each sub collection in firebase into Delivery, Payment, CreditCard and Address fields which uses the convinience init of those classes respectively.
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
    
    //get index by product code
    func getIndexByProductCode(productCodes: [Int],productCode : Int) -> Int{
        for (index,code) in productCodes.enumerated() {
            if productCode == code {
                return index
            }
        }
        return -1
    }
    
    //function that will use the productCode and productQuantity fields and get the data from Firebase and return an array of Product objects. It has a call back function as a parameter which can be used as a closure when the function is called
    func getProducts(callback: @escaping (_ products : [Product]) -> Void) {
        let db = Firestore.firestore()
        var products : [Product] = []
        
        db.collection("Products")
            .whereField("productCode", in: self.productCodes)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let product = Product(firebaseDictionary: document.data())
                        
                        let productQuantityIndex = self.productCodes.firstIndex(of: product.productCode)
                        
                        product.addedToCart = true
                        product.currentSelectedAmount = self.productQuantities[productQuantityIndex!]
                        
                        products.append(product)
                    }
                    callback(products)
                }
        }
    }
    
    //function that takes the current instance of the class and gives out a dictionary in the [String: Any] format the firebase uses
    var firebaseDictionary : [String: Any] {
        return ["productCodes" : productCodes, "productQuantities" : productQuantities , "totalItems" : totalItems, "customerId" : customerId]
    }

}
