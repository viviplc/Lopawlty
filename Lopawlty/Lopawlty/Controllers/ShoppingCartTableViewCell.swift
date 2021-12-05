//
//  ShoppingCartTableViewCell.swift
//  Lopawlty
//
//  Created by Viviana Leyva on 12/1/21.
//

/*
 This class is the table view cell for the shopping cart product list view. It has the buttons and information relating to an individual product in the list.
 **/

import UIKit

class ShoppingCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ProductBrand: UILabel!
    @IBOutlet weak var ProductTotalPrice: UILabel!
    @IBOutlet weak var ProductQuantity: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
