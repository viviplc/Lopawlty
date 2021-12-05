//
//  SampleData.swift
//  Lopawlty
//
//  Created by Dunumalage Romeno Fernando on 11/25/21.
//
/*
 This SampleData class was used to test the views by providing sample data.
 **/

import Foundation
import UIKit
import Firebase


class SampleData {
    
    //function that gives a sample list of Product objects for testing purposes
    static func getProducts() ->[Product] {
        var products : [Product] = []
        let productCodes = [1,2,3,4,5,6,7,8,9,10]
        
        let productsNames = ["dog food bag", "product longer name for test", "dog food bag testing testing", "Accessorie for dog@", "dog wet food packx12@", "food for lazy cats pckx10", "food for cats longer than others@", "cats food", "cats gym", "cats toys"]
        
        let productsImages = ["dog1","dog2","dog3","dog4","dog5","cat1","cat2","cat3","cat4","cat5"]
        
        let productsBrands = ["Brand 1","Brand 2","Brand 3","Brand 4","Brand 5 longer to test","Brand 6","Brand 7","Brand 8 longer to test","Brand 9","Brand 10 longer longer longer longer"]
        
        let productsPrices = [5.35, 1235.35,534.35,52.35,0.35,123.35,34555.35,5.35,52.35,465.35]
        
        for (i, productCode) in productCodes.enumerated() {
            let prod = Product(name: productsNames[i], price: productsPrices[i], productCode: productCode, brand: productsBrands[i], category: "", imageFileName: productsImages[i], description: "")
            prod.currentSelectedAmount = 2
            products.append(prod)
        }
 
        return products
        
    }
        
}
