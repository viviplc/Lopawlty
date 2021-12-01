//
//  ProductsListViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/18/21.
//

import UIKit
import Firebase
import CoreData

class ProductsListViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate{
   
    @IBOutlet weak var productsListtable: UITableView!
    @IBOutlet weak var BtnDogsFilter: UIButton!
    @IBOutlet weak var BtnCatsFilter: UIButton!
    
    
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let searchController = 	UISearchController(searchResultsController: nil)
    
    var products : [Product] = []
    
    var productsNotInCart : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        view.backgroundColor = .white
        
        productsListtable.delegate = self
        productsListtable.dataSource = self
        
        BtnDogsFilter.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        BtnDogsFilter.layer.cornerRadius = 10
        BtnDogsFilter.layer.borderWidth = 1
        BtnCatsFilter.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        BtnCatsFilter.layer.cornerRadius = 10
        BtnCatsFilter.layer.borderWidth = 1
        
        //SampleData.createSampleData()
        //loadProductsFromFirebase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadProductsFromFirebase()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productsNotInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCellTableViewCell
            
            let prdNameLbl = self.productsNotInCart[indexPath.row].name
            let prdBrandLbl = self.productsNotInCart[indexPath.row].brand
            let prdPriceLbl = "$\(self.productsNotInCart[indexPath.row].price)"
            let prdImageLbl = UIImage(named : self.productsNotInCart[indexPath.row].imageFileName)
            
            cell.productName.text = prdNameLbl
            cell.productBrand.text = prdBrandLbl
            cell.productPrice.text = prdPriceLbl
            cell.productImage.image = prdImageLbl
            
            cell.BtnSeeMore.tag = indexPath.row
            cell.BtnSeeMore.addTarget(self, action: #selector(ProductsListViewController.buttonTapped(_:)), for: UIControl.Event.touchUpInside)
            
            return cell
        }
        
        @objc func buttonTapped(_ sender:UIButton!){
            self.performSegue(withIdentifier: "productListToSeeMore", sender: sender)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "productListToSeeMore") {
                if let seeMoreDestination = segue.destination as? SeeMoreViewController {
                    if let seeMoreBtn:UIButton = sender as! UIButton? {
                        let prdImage:String! = self.productsNotInCart[seeMoreBtn.tag].imageFileName
                        let prdname:String! = self.productsNotInCart[seeMoreBtn.tag].name
                        let prdBrand:String! = self.productsNotInCart[seeMoreBtn.tag].brand
                        let prdPrice:String! = "$\(self.productsNotInCart[seeMoreBtn.tag].price)"
                        if (prdname != nil && prdImage != nil && prdBrand != nil && prdPrice != nil ){
                            seeMoreDestination.readProductImage = prdImage!
                            seeMoreDestination.readProductName = prdname!
                            seeMoreDestination.readProductBrand = prdBrand!
                            seeMoreDestination.readProductPrice = prdPrice!
                        }
                        
                    }
                }
            }
        }
    
    @IBAction func btnSubtractItemClicked(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint(), to: productsListtable)
        let index = productsListtable.indexPathForRow(at: buttonPosition)
        let productCode = Int64(productsNotInCart[index!.row].productCode)
        let mainProductListIndex = getIndexByProductCode(productList: products, productCode: productCode)
        if(productsNotInCart[index!.row].currentSelectedAmount > 1){
            productsNotInCart[index!.row].currentSelectedAmount -= 1
        }
        let cell = productsListtable.cellForRow(at: index!) as! ProductCellTableViewCell
        cell.productQuantity.text =  String(productsNotInCart[index!.row].currentSelectedAmount)
    }
    
    @IBAction func btnAddItemClicked(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint(), to: productsListtable)
        let index = productsListtable.indexPathForRow(at: buttonPosition)
        let productCode = Int64(productsNotInCart[index!.row].productCode)
        let mainProductListIndex = getIndexByProductCode(productList: products, productCode: productCode)
        if(productsNotInCart[index!.row].currentSelectedAmount < 9){
            productsNotInCart[index!.row].currentSelectedAmount += 1
        }
        let cell = productsListtable.cellForRow(at: index!) as! ProductCellTableViewCell
        cell.productQuantity.text =  String(productsNotInCart[index!.row].currentSelectedAmount)
    }
    
    @IBAction func btnAddToCartClicked(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint(), to: productsListtable)
        let index = productsListtable.indexPathForRow(at: buttonPosition)
        let productCode = Int64(productsNotInCart[index!.row].productCode)
        addProductToCart(productCode: productCode, numberOfProduct: Int32(productsNotInCart[index!.row].currentSelectedAmount))
        
        let productIndex = getIndexByProductCode(productList: products, productCode: productCode)
        products[productIndex].addedToCart = true;
        
        refreshProductsNotAddedToCart();
    }
    
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
    
    func refreshProductsNotAddedToCart() {
        productsNotInCart = []
        for (index,product) in products.enumerated() {
            if !product.addedToCart {
                productsNotInCart.append(product)
            }
        }
        self.productsListtable.reloadData()
    }
    
    func getIndexByProductCode(productList: [Product],productCode : Int64) -> Int{
        for (index,product) in productList.enumerated() {
            if product.productCode == productCode {
                return index
            }
        }
        return -1
    }
    
    func updateAddedToCartFieldInProducts() {
        do {
               let request = Cart.fetchRequest() as NSFetchRequest<Cart>
               let fetchResults = try managedContext.fetch(request)
            if fetchResults.count > 0 {
                for (index, cartItem) in fetchResults.enumerated() {
                    
                    let productsIndex = getIndexByProductCode(productList: products, productCode: cartItem.productCode)
                    products[productsIndex].addedToCart = true
                    products[productsIndex].currentSelectedAmount = Int(cartItem.count)
                }
                }
               } catch {
                   print("Error while using core data")
               }
    }
    
    func loadProductsFromFirebase() {
        var newProducts : [Product] = []
        let db = Firestore.firestore()
        db.collection("Products")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("product: \(document.data())")
                        newProducts.append(Product(firebaseDictionary: document.data()))
                        
                    }
                    
                    self.products = newProducts
                    
                    self.updateAddedToCartFieldInProducts()
                    
                    self.refreshProductsNotAddedToCart()
                }
        }
    }
}
