//
//  ProductsListViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/18/21.
//

import UIKit

class ProductsListViewController: UIViewController, UISearchBarDelegate{

    let searchController = 	UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        view.backgroundColor = .white
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    

}
