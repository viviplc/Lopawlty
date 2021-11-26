//
//  SampleData.swift
//  Lopawlty
//
//  Created by user194247 on 11/25/21.
//

import Foundation
import UIKit
import CoreData

class SampleData {
    
    static func createSampleData() {
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let productCodes = [1,2,3,4,5,6,7,8,9,10]
        
        let productsNames = ["dog food bag", "product longer name for test", "dog food bag testing testing", "Accessorie for dog", "dog wet food packx12", "food for lazy cats pckx10", "food for cats longer than others", "cats food", "cats gym", "cats toys"]
        
        let productsImages = ["dog1","dog2","dog3","dog4","dog5","cat1","cat2","cat3","cat4","cat5"]
        
        let productsBrands = ["Brand 1","Brand 2","Brand 3","Brand 4","Brand 5 longer to test","Brand 6","Brand 7","Brand 8 longer to test","Brand 9","Brand 10 longer longer longer longer"]
        
        let productsPrices = [5.35, 1235.35,534.35,52.35,0.35,123.35,34555.35,5.35,52.35,465.35]
        
        for (i, productCode) in productCodes.enumerated() {
            do{
                let request = Product.fetchRequest() as NSFetchRequest<Product>
                let pred = NSPredicate(format: "productCode = %d", productCode)
                request.predicate = pred
                let productExistsCheck = try managedContext.fetch(request)
                    if (productExistsCheck.count == 0){
                        let product = Product(context: managedContext)
                        product.productCode = Int32(productCode);
                        product.name = productsNames[i];
                        product.imageFileName = productsImages[i];
                        product.brand = productsBrands[i];
                        product.price = productsPrices[i];
                        try managedContext.save()
                        print("SUCCESS!");
                    } else {
                        print("Product already exists.");
                    }
                       } catch{
                           print("Error during saving data : \(error)")
                       }
        }
        }
    
    static func getProducts() ->[Product] {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            let request = Product.fetchRequest() as NSFetchRequest<Product>
            //let pred = NSPredicate(format: "productCode = %d", productCode)
            //request.predicate = pred
            let products = try managedContext.fetch(request)
            return products
                
                   } catch{
                       print("Error getting data : \(error)")
                        return []
                   }
        
        
    }
        
}
