//
//  AddressInformationViewController.swift
//  Lopawlty
//
//  Created by Viviana Leyva on 12/2/21.
//

/*
 This class is the controller for the address information view. It is integrated to firebase to save the information in the Sale. It uses MapKit and CoreLocation handle the mapView and geocoder to convert postal code to a location in the mapView.
 **/

import UIKit
import MapKit
import Firebase
import CoreLocation

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
    
    func validateAddressDetails() -> Bool {
        var validated = true
        var errorMessage = ""
        if(!Utils.validateTextFieldWithMinLen(txtLabel: LblAddressNum, min: 3)) {
            validated = false
            errorMessage += "Error with address info number (min length 3). "
        }
        
        if(!Utils.validateTextFieldWithMinLen(txtLabel: LblStreetName, min: 3)) {
            validated = false
            errorMessage += "Error with street name (min length 3). "
        }
        
        if(!Utils.validateTextField(txtLabel: LblComplementary)) {
            validated = false
            errorMessage += "Please fill in Complementary Info. "
        }
        
        if(!Utils.validateTextField(txtLabel: LblComplementary)) {
            validated = false
            errorMessage += "Please fill in Postal Code "
        }
        
        if(!validated) {
            Utils.alert(message: errorMessage, viewController: self)
        }
        
        return validated
    }
    
    @IBAction func btnContinueClicked(_ sender: Any) {
        //addressToConfirmation
        if(validateAddressDetails()) {
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
    
    @IBAction func PostalCodeRead(_ sender: UITextField) {
        var postalCode = LblPostal.text
        var city : String = ""
        if(postalCode?.count == 6){
            postalCode = validatePostalCode(postalCode: postalCode!)
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString((postalCode)!) {(placemarks, error) -> Void in
                if let placemark = placemarks?[0] {
                    if placemark.postalCode == postalCode{
                        let annotation = MKPlacemark(placemark: (placemarks?.first!)!)
                        self.mapView.addAnnotation(annotation)
                        let latDelta:CLLocationDegrees = 0.01
                        let lonDelta:CLLocationDegrees = 0.01
                        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
                        let region = MKCoordinateRegion(center: (placemark.location?.coordinate) as! CLLocationCoordinate2D, span: span)
                        self.mapView.setRegion(region, animated: true)
                    }
                    else{
                        print("Please enter valid zipcode")
                    }
                }
            }
        }
       
    }
    
    func validatePostalCode(postalCode: String) -> String {
        var postal : String = postalCode.uppercased()
        var postalComp = Array(postal)
        postalComp.insert(" ", at: 3)
        postal = String(postalComp)
        LblPostal.text = postal
        return postal
    }
    
    
    
    @objc func DismissKeyboard(){
    //Causes the view to resign from the status of first responder.
    view.endEditing(true)
    }

}
