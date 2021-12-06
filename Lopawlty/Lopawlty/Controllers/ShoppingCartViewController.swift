//
//  ShoppingCartViewController.swift
//  Lopawlty
//
//  Created by Viviana Leyva on 12/1/21.
//

/*
 This class is the controller for the shopping cart product list view. It has the buttons and information relating to an individual product in the list. It also gives the user the option to checkout their shopping cart.
 **/

import UIKit
import Firebase
import CoreData

class ShoppingCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ShoppingCartTable: UITableView!
    @IBOutlet weak var BtnCheckout: UIButton!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var productsInCart : [Product] = []
    var allProducts : [Product] = []
    
    var checkTotalItems : Int = 0
    var checkSubTotal : Double = 0.0
    var newSaleId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BtnCheckout.layer.cornerRadius = 10
        refreshTotalOrderAmountLabel()
        
        ShoppingCartTable.delegate = self
        ShoppingCartTable.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadProductsFromFirebase()
    }
    
    //method that creates a sale object by calculating and getting the data
    func createSale() -> Sale {
        let customerId = UserDefaults.standard.object(forKey: "LoggedInCustomerId")
        let totalItems = calculateTotalItems()
        let productCodes = getProductCodeArray()
        let productQuantities = getProductQuantities()
        let sale = Sale(productCodes: productCodes, productQuantities: productQuantities, customerId: customerId as! String, totalItems: totalItems)
        
        return sale
    }
    
    //method that iterates through a list of products and returns an array of the product codes
    func getProductCodeArray() -> [Int] {
        var productCodes : [Int] = []
        for product in productsInCart {
            productCodes.append(product.productCode)
        }
        return productCodes
    }
    
    //method that iterates through a list of products and returns an array of the product quantities
    func getProductQuantities() -> [Int] {
        var productCodes : [Int] = []
        for product in productsInCart {
            productCodes.append(product.currentSelectedAmount)
        }
        return productCodes
    }
    
    //method that iterates through the list of products and calculates the total cost
    func calculateTotalOrder() -> Double {
        var total = 0.0
        
        for product in self.productsInCart {
            total += product.price * Double(product.currentSelectedAmount)
        }
        
        return total
    }
    
    //method that iterates through the list of products and calculates the total number of items
    func calculateTotalItems() -> Int {
        var total = 0
        
        for product in self.productsInCart {
            total += product.currentSelectedAmount
        }
        
        return total
    }
    
    //method that refreshes the checkout total label after calculating it
    func refreshTotalOrderAmountLabel() {
        let checkOutTotal = String(format: "%.2f",calculateTotalOrder())
        BtnCheckout.setTitle("   Check Out $ \(checkOutTotal)", for: .normal)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //productsToBuy.count
        productsInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingCartTableViewCell
        
        let prdNameLbl = self.productsInCart[indexPath.row].name
        let prdBrandLbl = self.productsInCart[indexPath.row].brand
        let prdPriceLbl = "$ \(self.productsInCart[indexPath.row].price)"
        let prdImageLbl = UIImage(named: self.productsInCart[indexPath.row].imageFileName)
        
        cell.ProductName.text = prdNameLbl
        cell.ProductBrand.text = prdBrandLbl
        cell.ProductTotalPrice.text = prdPriceLbl
        cell.ProductImage.image = prdImageLbl
        
        cell.ProductQuantity.text = String(self.productsInCart[indexPath.row].currentSelectedAmount)
        
        return cell
    }
    
    
    @IBAction func btnDeleteCartItemClicked(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint(), to: ShoppingCartTable)
        let index = ShoppingCartTable.indexPathForRow(at: buttonPosition)
        let productCode = Int64(productsInCart[index!.row].productCode)
        deleteCartItemInCoreData(productCode: productCode)
        productsInCart.remove(at: index!.row)
        ShoppingCartTable.deleteRows(at: [index!], with: .fade)
        refreshTotalOrderAmountLabel()
    }
    
        
    @IBAction func btnSubtractCartItemClicked(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint(), to: ShoppingCartTable)
        let index = ShoppingCartTable.indexPathForRow(at: buttonPosition)
        let productCode = Int64(productsInCart[index!.row].productCode)
        let mainProductListIndex = getIndexByProductCode(productList: allProducts, productCode: productCode)
        if(productsInCart[index!.row].currentSelectedAmount > 1){
            productsInCart[index!.row].currentSelectedAmount -= 1
            let cell = ShoppingCartTable.cellForRow(at: index!) as! ShoppingCartTableViewCell
            cell.ProductQuantity.text =  String(productsInCart[index!.row].currentSelectedAmount)
            updateCartItemCountInCoreData(productCode: productCode, productCount: Int32(productsInCart[index!.row].currentSelectedAmount))
            }
        refreshTotalOrderAmountLabel()
    }
    
    
    @IBAction func btnAddCartItemClicked(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint(), to: ShoppingCartTable)
        let index = ShoppingCartTable.indexPathForRow(at: buttonPosition)
        let productCode = Int64(productsInCart[index!.row].productCode)
        let mainProductListIndex = getIndexByProductCode(productList: allProducts, productCode: productCode)
        if(productsInCart[index!.row].currentSelectedAmount < 9){
            productsInCart[index!.row].currentSelectedAmount += 1
            let cell = ShoppingCartTable.cellForRow(at: index!) as! ShoppingCartTableViewCell
            cell.ProductQuantity.text =  String(productsInCart[index!.row].currentSelectedAmount)
            updateCartItemCountInCoreData(productCode: productCode, productCount: Int32(productsInCart[index!.row].currentSelectedAmount))
        }
        refreshTotalOrderAmountLabel()
    }
    
    //method that updates the cart item count for a specific cart item
    func updateCartItemCountInCoreData(productCode: Int64, productCount: Int32) {
        do {
               let request = Cart.fetchRequest() as NSFetchRequest<Cart>
               let pred = NSPredicate(format: "productCode = %d",productCode)
               request.predicate = pred
               let fetchResults = try managedContext.fetch(request)
            if fetchResults.count == 1 {
                let cartItem : Cart = fetchResults[0]
                cartItem.productCode = productCode
                cartItem.count = productCount
                try managedContext.save()
                print("updated cart  item \(productCode) with quantity \(productCount)")
                }
               } catch {
                   print("Error while using core data")
               }
    }
    
    //method that deletes a cart item from core data
    func deleteCartItemInCoreData(productCode: Int64) {
        do {
               let request = Cart.fetchRequest() as NSFetchRequest<Cart>
               let pred = NSPredicate(format: "productCode = %d",productCode)
               request.predicate = pred
               let fetchResults = try managedContext.fetch(request)
            if fetchResults.count == 1 {
                let cartItem : Cart = fetchResults[0]
                managedContext.delete(cartItem)
                try managedContext.save()
                print("deleted cart  item \(productCode)")
                }
               } catch {
                   print("Error while using core data")
               }
    }
    
    //method that updates product addedToCart and currentSelectedAmount fields
    func updateAddedToCartFieldInCartProducts() {
        do {
               let request = Cart.fetchRequest() as NSFetchRequest<Cart>
               let fetchResults = try managedContext.fetch(request)
            if fetchResults.count > 0 {
                for (index, cartItem) in fetchResults.enumerated() {
                    let productsIndex = getIndexByProductCode(productList: allProducts, productCode: cartItem.productCode)
                    allProducts[productsIndex].addedToCart = true
                    allProducts[productsIndex].currentSelectedAmount = Int(cartItem.count)
                }
                }
               } catch {
                   print("Error while using core data")
               }
    }
    
    //method that will return the index of a product from the product list by product code
    func getIndexByProductCode(productList: [Product],productCode : Int64) -> Int{
        for (index,product) in productList.enumerated() {
            if product.productCode == productCode {
                return index
            }
        }
        return -1
    }
    
    //method to load the products from firebase
    func loadProductsFromFirebase() {
        let db = Firestore.firestore()
        db.collection("Products")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.allProducts.append(Product(firebaseDictionary: document.data()))
                    }
                    self.updateAddedToCartFieldInCartProducts()
                    self.refreshProductsAddedToCart()
                    self.refreshTotalOrderAmountLabel()
                }
        }
    }
    
    //method to refresh the products added to cart by checking the addedToCart field
    func refreshProductsAddedToCart() {
        productsInCart = []
        for (index,product) in allProducts.enumerated() {
            if product.addedToCart {
                productsInCart.append(product)
            }
        }
        self.ShoppingCartTable.reloadData()
    }
    
    
    @IBAction func BtnCheckOutClicked(_ sender: Any) {
        self.checkTotalItems = calculateTotalItems()
        self.checkSubTotal = calculateTotalOrder()
        let newSale : Sale = createSale()
        
        saveSaleToFirebase(newSale: newSale)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.destination is CheckOutResumeViewController {
                let resume = segue.destination as? CheckOutResumeViewController
                resume?.totalItems = self.checkTotalItems
                resume?.subTotal = self.checkSubTotal
                resume?.saleId = self.newSaleId
            }
        }
    
    //method to store sale in firebase firestore database
    func saveSaleToFirebase(newSale : Sale) {
        let db = Firestore.firestore()
        let ref = db.collection("Sales").document()
        let newId = ref.documentID
        
        let firebaseNewSaleDict = newSale.firebaseDictionary;
        db.collection("Sales").document(newId).setData( firebaseNewSaleDict){ err in
            if let err = err {
                print("error adding new sale: \(err)")
            } else {
                self.newSaleId = newId
                print("saved new sale with id \(newId)")
                self.performSegue(withIdentifier: "shoppingCartToResume", sender: self)
            }
        }
    }
    
}
