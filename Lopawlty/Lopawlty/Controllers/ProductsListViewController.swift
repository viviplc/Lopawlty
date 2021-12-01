//
//  ProductsListViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/18/21.
//

import UIKit
import Firebase

class ProductsListViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate{
   
    @IBOutlet weak var productsListtable: UITableView!
    @IBOutlet weak var BtnDogsFilter: UIButton!
    @IBOutlet weak var BtnCatsFilter: UIButton!
    
    let searchController = 	UISearchController(searchResultsController: nil)
    
    var products : [Product] = []
    
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
        let db = Firestore.firestore()
        db.collection("Products")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("product: \(document.data())")
                        self.products.append(Product(firebaseDictionary: document.data()))
                        
                    }
                    self.productsListtable.reloadData()
                    
                }
        }
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
            let prdImageLbl = UIImage(named : self.products[indexPath.row].imageFileName)
            
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
                        let prdImage:String! = self.products[seeMoreBtn.tag].imageFileName
                        let prdname:String! = self.products[seeMoreBtn.tag].name
                        let prdBrand:String! = self.products[seeMoreBtn.tag].brand
                        let prdPrice:String! = "$\(self.products[seeMoreBtn.tag].price)"
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

}
