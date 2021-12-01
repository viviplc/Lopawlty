//
//  ShoppingCartViewController.swift
//  Lopawlty
//
//  Created by user193926 on 12/1/21.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ShoppingCartTable: UITableView!
    @IBOutlet weak var BtnCheckout: UIButton!
    
    //var productsToBuy : [Product] = []
    
    let productsNames = ["dog food bag", "product longer name for test", "dog food bag testing testing", "Accessorie for dog", "dog wet food packx12", "food for lazy cats pckx10", "food for cats longer than others", "cats food", "cats gym", "cats toys"]

        let productsImages = [UIImage(named: "dog1"),UIImage(named: "dog2"),UIImage(named: "dog3"),UIImage(named: "dog4"),UIImage(named: "dog5"),UIImage(named: "cat1"),UIImage(named: "cat2"),UIImage(named: "cat3"),UIImage(named: "cat4"),UIImage(named: "cat5")]

        let productsBrands = ["Brand 1","Brand 2","Brand 3","Brand 4","Brand 5 longer to test","Brand 6","Brand 7","Brand 8 longer to test","Brand 9","Brand 10 longer longer longer longer"]

        let productsPrices = ["5,35", "1235,35","534,35","52,35","0,35","123,35","34555,35","5,35","52,35","465,35"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BtnCheckout.layer.cornerRadius = 10
        let checkOutTotal = calculateTotalOrder()
        BtnCheckout.setTitle("   Check Out $ \(checkOutTotal)", for: .normal)
        
        ShoppingCartTable.delegate = self
        ShoppingCartTable.dataSource = self
    }
    
    func calculateTotalOrder() -> Double {
        var total = 0.0
        
        for price in self.productsPrices {
            total += (price as NSString).doubleValue
            
        }
        
        return total
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //productsToBuy.count
        productsNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingCartTableViewCell
        
        let prdNameLbl = self.productsNames[indexPath.row]
        let prdBrandLbl = self.productsBrands[indexPath.row]
        let prdPriceLbl = "$ \(self.productsPrices[indexPath.row])"
        let prdImageLbl = self.productsImages[indexPath.row]
        
        cell.ProductName.text = prdNameLbl
        cell.ProductBrand.text = prdBrandLbl
        cell.ProductTotalPrice.text = prdPriceLbl
        cell.ProductImage.image = prdImageLbl
        
        return cell
    }
    

}
