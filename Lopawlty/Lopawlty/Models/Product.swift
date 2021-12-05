//
//  Product.swift
//  Lopawlty
//
//  Created by Dunumalage Romeno Fernando on 11/30/21.
//

/**
 This class is the model for a Product which is a single product in our app. It provides the functionality to initialize using a Firebase Collection Dictionary, to get get product data. It also has fields such as current selected amount in cart in addition to the product fields.
 */
import Foundation

class Product {
    
    var name: String
    var price : Double
    var productCode : Int
    var brand : String
    var category : String
    var imageFileName : String
    var description : String
    var currentSelectedAmount : Int = 1
    var addedToCart : Bool = false
    
    init(name: String, price : Double, productCode : Int, brand: String, category : String, imageFileName : String, description : String) {
        self.name = name
        self.price = price
        self.productCode = productCode
        self.brand = brand
        self.category = category
        self.imageFileName = imageFileName
        self.description = description
    }
    
    //a convenience constructor that takes a firebase dictionary. This is used when we have a firebase object of data and want to convert it to this class
    convenience init(firebaseDictionary : [String: Any]) {
        let name = firebaseDictionary["name"] as! String? ?? ""
        let price = firebaseDictionary["price"] as! Double? ?? 0.0
        let productCode = firebaseDictionary["productCode"] as! Int? ?? 0
        let brand = firebaseDictionary["brand"] as! String? ?? ""
        let category = firebaseDictionary["category"] as! String? ?? ""
        let imageFileName = firebaseDictionary["imageFileName"] as! String? ?? ""
        let description = firebaseDictionary["description"] as! String? ?? ""
        
        self.init(name: name, price: price, productCode: productCode, brand: brand, category: category, imageFileName:imageFileName, description : description)
    }
    
}
