
//
//  SeeMoreViewController.swift
//  Lopawlty
//
//  Created by Viviana Leyva on 11/30/21.
//

/*
 This class is the detail view for a single product. 
 **/

import UIKit
import CoreData

class SeeMoreViewController: UIViewController {
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var LblProductName: UILabel!
    @IBOutlet weak var LblProductPrice: UILabel!
    @IBOutlet weak var LblProductBrand: UILabel!
    @IBOutlet weak var LblProductQuantity: UILabel!
    @IBOutlet weak var LblProductDescription: UILabel!
    
    @IBOutlet weak var btnAddToCart: UIButton!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //writable variables
    var readProductCode : Int = 0
    var readProductImage = ""
    var readProductName = ""
    var readProductPrice = ""
    var readProductBrand = ""
    var readProductQuantity = ""
    var readProductDescription = ""
    
    var currentSelectedAmount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductImage.image = UIImage(named: readProductImage)
        LblProductName.text = readProductName
        LblProductBrand.text = readProductBrand
        LblProductPrice.text = readProductPrice
        LblProductDescription.text = readProductDescription
    }
    
    @IBAction func btnSubtractCartItemClicked(_ sender: Any) {
        if(currentSelectedAmount > 1){
            currentSelectedAmount -= 1
        }
        LblProductQuantity.text =  String(currentSelectedAmount)
    }
    
    @IBAction func btnAddCartItemClicked(_ sender: Any) {
        if(currentSelectedAmount < 9){
            currentSelectedAmount += 1
        }
        LblProductQuantity.text =  String(currentSelectedAmount)
    }
    
    @IBAction func btnAddToCartClicked(_ sender: Any) {
        let productCode = Int64(readProductCode)
        let numberOfProducts = Int32(currentSelectedAmount)
        addProductToCart(productCode: productCode, numberOfProduct: numberOfProducts)
        btnAddToCart.setTitle("Added to Cart", for : .normal)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.btnAddToCart.setTitle("Add to Cart", for : .normal)
        }
        
    }
    
    //method that adds a product to the cart in Core Data
    func addProductToCart(productCode : Int64, numberOfProduct : Int32) {
        do {
               let request = Cart.fetchRequest() as NSFetchRequest<Cart>
               let pred = NSPredicate(format: "productCode = %d",productCode)
               request.predicate = pred
               let fetchResults = try managedContext.fetch(request)
            if fetchResults.count == 1 {
                let cartItem : Cart = fetchResults[0]
                cartItem.productCode = productCode
                cartItem.count = numberOfProduct
                try managedContext.save()
                print("updated cart  item \(productCode) with quantity \(numberOfProduct)")
                } else {
                    //create new obj
                    let newCartItem : Cart = Cart(context: managedContext)
                    newCartItem.productCode = productCode
                    newCartItem.count = numberOfProduct
                    try managedContext.save()
                    print("created new cart item \(productCode) with quantity \(numberOfProduct)")
                }
               } catch {
                   print("Error while using core data")
               }
        
    }
    
}
