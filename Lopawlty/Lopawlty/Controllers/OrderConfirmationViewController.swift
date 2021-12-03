//
//  OrderConfirmationViewController.swift
//  Lopawlty
//
//  Created by user193926 on 12/2/21.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var BtnSeeItems: UIButton!
    @IBOutlet weak var BtnPaymentMethod: UIButton!
    @IBOutlet weak var BtnDate: UIButton!
    
    @IBOutlet weak var LblSubtotal: UILabel!
    @IBOutlet weak var LblFeesTaxes: UILabel!
    @IBOutlet weak var LblGrandTotal: UILabel!
    @IBOutlet weak var LblDayWeek: UILabel!
    @IBOutlet weak var LblDayNum: UILabel!
    @IBOutlet weak var LblMonth: UILabel!
    @IBOutlet weak var LblTimeInterval: UILabel!
    @IBOutlet weak var LblAddress: UILabel!
    @IBOutlet weak var LblComplementary: UILabel!
    @IBOutlet weak var LblCityPostal: UILabel!
    
    @IBOutlet weak var ShippingViewInfo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonsStyles()
        infoTest()

        
    }
    
    func infoTest() {
        LblSubtotal.text = "$ 25.36"
        LblFeesTaxes.text = "$ 5.34"
        LblGrandTotal.text = "$ 45.67"
        LblDayWeek.text = "Wednesday"
        LblDayNum.text = "30"
        LblMonth.text = "Dec"
        LblTimeInterval.text = "9:00 AM - 11:00 AM"
        LblAddress.text = "275 Larch Street"
        LblComplementary.text = "Building B Unit 301"
        LblCityPostal.text = "Waterloo, ON N2R 2L5"
    }
    
    func setButtonsStyles() {
        BtnSeeItems.layer.borderWidth = 1
        BtnSeeItems.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        BtnSeeItems.layer.cornerRadius = 15
        BtnPaymentMethod.layer.borderWidth = 1
        BtnPaymentMethod.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        BtnPaymentMethod.layer.cornerRadius = 15
        BtnDate.layer.borderWidth = 1
        BtnDate.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        LblTimeInterval.layer.cornerRadius = 15
        LblTimeInterval.layer.borderWidth = 1
        LblTimeInterval.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        ShippingViewInfo.layer.borderWidth = 2
        ShippingViewInfo.layer.borderColor = UIColor(red: 204/255, green: 228/255, blue: 255/255, alpha: 1).cgColor
    }
    

    

}
