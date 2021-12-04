//
//  OrderHistoricListViewController.swift
//  Lopawlty
//
//  Created by user193926 on 12/3/21.
//

import UIKit

class Order{
    var dayWeek = ""
    var dayNum = ""
    var month = ""
    var timeInter = ""
    var status = ""
    var totalItems = ""
    var grandTotal = ""
    
    init(dayWeek:String, dayNum:String, month:String, timeInter: String, status:String, totalItems:String, grandTotal: String){
        self.dayWeek = dayWeek
        self.dayNum = dayNum
        self.month = month
        self.timeInter = timeInter
        self.status = status
        self.totalItems = totalItems
        self.grandTotal = grandTotal
    }
}

class OrderHistoricListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var ordersTable: UITableView!
    

    var orders:[Order] = []
    let order1:Order = Order(dayWeek:"Monday", dayNum:"5", month:"Nov", timeInter: "11:00 AM - 1:00 PM", status:"In progress", totalItems:"2", grandTotal: "$ 356.76")
    let order2:Order = Order(dayWeek:"Wednesday", dayNum:"5", month:"Nov", timeInter: "11:00 AM - 1:00 PM", status:"In progress", totalItems:"2", grandTotal: "$ 23435.76")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orders.append(order1)
        orders.append(order2)
        
        print(orders)
        
        ordersTable.delegate = self
        ordersTable.dataSource = self

        // Do any additional setup after loading the view.
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
        let dayWeek = self.orders[indexPath.row].dayWeek
        let dayNum = self.orders[indexPath.row].dayNum
        let month = self.orders[indexPath.row].month
        let timeInter = self.orders[indexPath.row].timeInter
        let status = self.orders[indexPath.row].status
        let totalItems = self.orders[indexPath.row].totalItems
        let grandTotal = self.orders[indexPath.row].grandTotal
        
        cell.LblDayWeek.text = dayWeek
        cell.LblDayNum.text = dayNum
        cell.LblMonth.text = month
        cell.LblTimeInterval.text = timeInter
        cell.LblOrderStatus.text = status
        cell.LblTotalItems.text = totalItems
        cell.LblGrandTotal.text = grandTotal
        cell.BtnSeeItems.tag = indexPath.row
        
        /*
        cell.BtnSeeMore.addTarget(self, action: #selector(ProductsListViewController.buttonTapped(_:)), for: UIControl.Event.touchUpInside)
        */
        return cell
    }

    

}
