//
//  OrderItemsViewController.swift
//  Lopawlty
//
//  Created by user193926 on 12/3/21.
//

import UIKit

class OrderItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var orderItemsTable: UITableView!
    

    var orderItems : [Product] = SampleData.getProducts()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        orderItemsTable.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as! OderItemCellTableViewCell
        let prdNameLbl = self.orderItems[indexPath.row].name
        let prdBrandLbl = self.orderItems[indexPath.row].brand
        let prdPriceLbl = "$ \(self.orderItems[indexPath.row].price)"
        let prdImageLbl = UIImage(named: self.orderItems[indexPath.row].imageFileName)
        let prdQuatityLbl = "\(self.orderItems[indexPath.row].currentSelectedAmount)"
        
        cell.LblProductName.text = prdNameLbl
        cell.LblProductBrand.text = prdBrandLbl
        cell.LblProductPrice.text = prdPriceLbl
        cell.ImgProduct.image = prdImageLbl
        cell.LblProductQuantity.text = prdQuatityLbl
        
        return cell
    }
    
    

}
