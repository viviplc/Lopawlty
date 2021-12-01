
//
//  SeeMoreViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/30/21.
//

import UIKit

class SeeMoreViewController: UIViewController {
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var LblProductName: UILabel!
    @IBOutlet weak var LblProductPrice: UILabel!
    @IBOutlet weak var LblProductBrand: UILabel!
    @IBOutlet weak var LblProductQuantity: UILabel!
    @IBOutlet weak var LblProductDescription: UILabel!
    
    //writable variables
    var readProductImage = ""
    var readProductName = ""
    var readProductPrice = ""
    var readProductBrand = ""
    var readProductQuantity = ""
    var readProductDescription = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductImage.image = UIImage(named: readProductImage)
        LblProductName.text = readProductName
        LblProductBrand.text = readProductBrand
        LblProductPrice.text = readProductPrice
        
    }
    

    

}
