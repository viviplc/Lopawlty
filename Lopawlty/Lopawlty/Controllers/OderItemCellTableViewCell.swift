//
//  OderItemCellTableViewCell.swift
//  Lopawlty
//
//  Created by user193926 on 12/3/21.
//

import UIKit

class OderItemCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ImgProduct: UIImageView!
    @IBOutlet weak var LblProductName: UILabel!
    @IBOutlet weak var LblProductBrand: UILabel!
    @IBOutlet weak var LblProductQuantity: UILabel!
    @IBOutlet weak var LblProductPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
