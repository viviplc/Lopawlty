//
//  ShoppingCartViewController.swift
//  Lopawlty
//
//  Created by user193926 on 12/1/21.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var BtnCheckout: UIButton!
    
    var productsToBuy : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BtnCheckout.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productsToBuy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingCartTableViewCell
        
        
        
        return cell
    }
    

}
