//
//  OrderHistoricCellTableViewCell.swift
//  Lopawlty
//
//  Created by Viviana Leyva on 12/3/21.
//

/*
 This class is the table view cell for the order item product list view.
 **/


import UIKit

class OrderHistoricCellTableViewCell: UITableViewCell {

    @IBOutlet weak var BtnDay: UIButton!
    @IBOutlet weak var BtnSeeItems: UIButton!
    
    @IBOutlet weak var LblDayWeek: UILabel!
    @IBOutlet weak var LblDayNum: UILabel!
    @IBOutlet weak var LblMonth: UILabel!
    @IBOutlet weak var LblTimeInterval: UILabel!
    @IBOutlet weak var LblOrderStatus: UILabel!
    @IBOutlet weak var LblTotalItems: UILabel!
    @IBOutlet weak var LblGrandTotal: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        BtnDay.layer.borderWidth = 1
        BtnDay.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        BtnSeeItems.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
