//
//  ProductsListViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/18/21.
//

import UIKit

class ProductsListViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate{
   
    @IBOutlet weak var productsListtable: UITableView!
    
    let searchController = 	UISearchController(searchResultsController: nil)
    
    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        view.backgroundColor = .white
        
        productsListtable.delegate = self
        productsListtable.dataSource = self
        
        SampleData.createSampleData()
        products = SampleData.getProducts()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCellTableViewCell
        
        let prdNameLbl = self.products[indexPath.row].name
        let prdBrandLbl = self.products[indexPath.row].brand
        let prdPriceLbl = "$\(self.products[indexPath.row].price)"
        let prdImageLbl = UIImage(named : self.products[indexPath.row].imageFileName!)
        
        cell.productName.text = prdNameLbl
        cell.productBrand.text = prdBrandLbl
        cell.productPrice.text = prdPriceLbl
        cell.productImage.image = prdImageLbl
        
        return cell
    }

}
