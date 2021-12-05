//
//  OrderHistoricListViewController.swift
//  Lopawlty
//
//  Created by Viviana Leyva on 12/3/21.
//

/*
 This class is the controller for the order history items product list view.
 **/

import UIKit
import Firebase


class OrderHistoricListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var ordersTable: UITableView!
    
    var orders:[Sale] = []
    var selectedOrderProducts:[Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersTable.delegate = self
        ordersTable.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getLoggedInUserOrders() { (orders) in
            self.orders = orders
            self.ordersTable.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderItemCell", for: indexPath) as! OrderHistoricCellTableViewCell
        print(self.orders)
        let dayWeek = self.orders[indexPath.row].delivery.deliveryDayName
        let dayNum = self.orders[indexPath.row].delivery.deliveryDayNumber
        let month = self.orders[indexPath.row].delivery.deliveryMonth
        let timeInter = self.orders[indexPath.row].delivery.deliveryTimeRange
        let status = "In progress"
        let totalItems = String(self.orders[indexPath.row].totalItems)
        let grandTotal = String(format: "%.2f", self.orders[indexPath.row].payment.totalCost)
        
        cell.LblDayWeek.text = dayWeek
        cell.LblDayNum.text = dayNum
        cell.LblMonth.text = month
        cell.LblTimeInterval.text = timeInter
        cell.LblOrderStatus.text = status
        cell.LblTotalItems.text = totalItems
        cell.LblGrandTotal.text = "$\(grandTotal)"
        cell.BtnSeeItems.tag = indexPath.row
        
        /*
        cell.BtnSeeMore.addTarget(self, action: #selector(ProductsListViewController.buttonTapped(_:)), for: UIControl.Event.touchUpInside)
        */
        return cell
    }
    
    
    
    @IBAction func btnSeeItemsClicked(_ sender: UIButton) {
        //OrdersToOrderItems
        let buttonPosition = sender.convert(CGPoint(), to: ordersTable)
        let index = ordersTable.indexPathForRow(at: buttonPosition)
        let selectedSale = orders[index!.row]
        selectedSale.getProducts() { products in
            self.selectedOrderProducts = products
            self.performSegue(withIdentifier: "OrdersToOrderItems", sender: self)
        }
    }
    

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is OrderItemsViewController {
            let resume = segue.destination as? OrderItemsViewController
            resume?.orderItems = self.selectedOrderProducts
        }
    }
    
    func getLoggedInUserOrders(callback: @escaping (_ order : [Sale]) -> Void) {
        let loggedInUserId : String = UserDefaults.standard.object(forKey: "LoggedInCustomerId")! as! String
         //just get the sales separately and get products only when seguing
        let db = Firestore.firestore()
        var orders : [Sale]  = []
        db.collection("Sales")
            .whereField("customerId", isEqualTo: loggedInUserId)
            .whereField("status", isEqualTo: "complete")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("product: \(document.data())")
                        orders.append(Sale(firebaseDictionary: document.data()))
                        
                    }
                    
                    callback(orders)
                }
        }
    }

    

}
