//
//  Product.swift
//  Lopawlty
//
//  Created by user194247 on 11/30/21.
//

import Foundation

class Product {
    
    var name: String
    var price : Double
    var productCode : Int
    var brand : String
    var category : String
    var imageFileName : String
    var currentSelectedAmount : Int = 1
    var addedToCart : Bool = false
    
    init(name: String, price : Double, productCode : Int, brand: String, category : String, imageFileName : String) {
        self.name = name
        self.price = price
        self.productCode = productCode
        self.brand = brand
        self.category = category
        self.imageFileName = imageFileName
    }
    
 
    convenience init(firebaseDictionary : [String: Any]) {
        let name = firebaseDictionary["name"] as! String? ?? ""
        let price = firebaseDictionary["price"] as! Double? ?? 0.0
        let productCode = firebaseDictionary["productCode"] as! Int? ?? 0
        let brand = firebaseDictionary["brand"] as! String? ?? ""
        let category = firebaseDictionary["category"] as! String? ?? ""
        let imageFileName = firebaseDictionary["imageFileName"] as! String? ?? ""
        
        self.init(name: name, price: price, productCode: productCode, brand: brand, category: category, imageFileName:imageFileName)
    }
    
}
