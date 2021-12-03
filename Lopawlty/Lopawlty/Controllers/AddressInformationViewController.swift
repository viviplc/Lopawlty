//
//  AddressInformationViewController.swift
//  Lopawlty
//
//  Created by user194247 on 12/2/21.
//

import UIKit
import MapKit

class AddressInformationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var BtnCreateAccount: UIButton!
    
    @IBOutlet weak var LblAddressNum: UITextField!
    @IBOutlet weak var LblStreetName: UITextField!
    @IBOutlet weak var LblComplementary: UITextField!
    @IBOutlet weak var LblPostal: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyles()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        self.view.addGestureRecognizer(tap)        // Do any additional setup after loading the view.
    }
    
    func setStyles(){
        BtnCreateAccount.layer.cornerRadius = 15
        LblAddressNum.attributedPlaceholder = NSAttributedString(string: "123", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        LblStreetName.attributedPlaceholder = NSAttributedString(string: "Street Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        LblComplementary.attributedPlaceholder = NSAttributedString(string: "Building, House, Unit", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        LblPostal.attributedPlaceholder = NSAttributedString(string: "XXX XXX", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    @IBAction func btnCreateAccountClicked(_ sender: Any) {
    }
    
    
    @objc func DismissKeyboard(){
    //Causes the view to resign from the status of first responder.
    view.endEditing(true)
    }

}
