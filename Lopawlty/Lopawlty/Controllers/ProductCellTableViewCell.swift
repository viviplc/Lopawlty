//
//  ProductCellTableViewCell.swift
//  Lopawlty
//
//  Created by user193926 on 11/20/21.
//

import UIKit

class ProductCellTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var BtnSeeMore: UIButton!
    @IBOutlet weak var BtnAddToCart: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        BtnSeeMore.layer.borderWidth = 1
        BtnSeeMore.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        BtnSeeMore.layer.cornerRadius = 10
        BtnAddToCart.layer.cornerRadius = 10
    }
    
    func test123() {
        
    }

}
