//
//  DeliveryInfoViewController.swift
//  Lopawlty
//
//  Created by user193926 on 12/1/21.
//

import UIKit

class DeliveryInfoViewController: UIViewController {

   
    @IBOutlet weak var Btn9AM: UIButton!
    @IBOutlet weak var Btn11AM: UIButton!
    @IBOutlet weak var Btn1PM: UIButton!
    @IBOutlet weak var Btn3PM: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Btn9AM.layer.cornerRadius = 15
        Btn9AM.layer.borderWidth = 1
        Btn9AM.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        Btn11AM.layer.cornerRadius = 15
        Btn11AM.layer.borderWidth = 1
        Btn11AM.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        Btn1PM.layer.cornerRadius = 15
        Btn1PM.layer.borderWidth = 1
        Btn1PM.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        Btn3PM.layer.cornerRadius = 15
        Btn3PM.layer.borderWidth = 1
        Btn3PM.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
    }
   
}
