//
//  AddressInformationViewController.swift
//  Lopawlty
//
//  Created by user194247 on 12/2/21.
//

import UIKit
import MapKit
import Firebase

class AddressInformationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var BtnContinue: UIButton!
    
    @IBOutlet weak var LblAddressNum: UITextField!
    @IBOutlet weak var LblStreetName: UITextField!
    @IBOutlet weak var LblComplementary: UITextField!
    @IBOutlet weak var LblPostal: UITextField!
    
    var saleId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyles()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        self.view.addGestureRecognizer(tap)        // Do any additional setup after loading the view.
    }
    
    func setStyles(){
        BtnContinue.layer.cornerRadius = 15
        LblAddressNum.attributedPlaceholder = NSAttributedString(string: "123", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        LblStreetName.attributedPlaceholder = NSAttributedString(string: "Street Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        LblComplementary.attributedPlaceholder = NSAttributedString(string: "Building, House, Unit", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        LblPostal.attributedPlaceholder = NSAttributedString(string: "XXX XXX", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    
    @IBAction func btnContinueClicked(_ sender: Any) {
        //addressToConfirmation
        let newAddress = createAddress()
        let db = Firestore.firestore()
        let firebaseNewAddressDict = newAddress.firebaseDictionary;
        db.collection("Sales").document(saleId).setData( ["address" : firebaseNewAddressDict], merge: true){ err in
            if let err = err {
                print("error adding address: \(err)")
            } else {
                print("updated address of sale \(self.saleId)")
                self.performSegue(withIdentifier: "addressToConfirmation", sender: self)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.destination is OrderConfirmationViewController {
                let resume = segue.destination as? OrderConfirmationViewController
                resume?.saleId = self.saleId
            }
        }
    
    
    func createAddress() -> Address {
        let street =  "\(LblAddressNum.text!) \(LblStreetName.text!)"
        let complementaryInfo = LblComplementary.text!
        let postalCode = LblPostal.text!
        let address = Address(street: street, complementaryInfo: complementaryInfo, postalCode: postalCode)
        return address
    }
    
    
    @objc func DismissKeyboard(){
    //Causes the view to resign from the status of first responder.
    view.endEditing(true)
    }

}
