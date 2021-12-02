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
    @IBOutlet weak var TxtStreetNumber: UITextField!
    @IBOutlet weak var TxtStreetName: UITextField!
    @IBOutlet weak var TxtComplementaryInfo: UITextField!
    @IBOutlet weak var TxtPostalCode: UITextField!
    @IBOutlet weak var BtnCreateAccount: UIButton!
    @IBOutlet weak var StackViewFormInputsContainer: UIStackView!
    @IBOutlet weak var StackViewStreetFormInput: UIStackView!
    
    @IBOutlet weak var StackViewFullFormContainer: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BtnCreateAccount.layer.cornerRadius = 15
        StackViewStreetFormInput.setCustomSpacing(5.0, after: StackViewStreetFormInput.subviews[0])
        StackViewFormInputsContainer.spacing = 5
        StackViewFullFormContainer.spacing = 15
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        self.view.addGestureRecognizer(tap)        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnCreateAccountClicked(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func DismissKeyboard(){
    //Causes the view to resign from the status of first responder.
    view.endEditing(true)
    }

}
