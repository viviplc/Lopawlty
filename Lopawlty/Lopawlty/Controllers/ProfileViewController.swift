//
//  ProfileViewController.swift
//  Lopawlty
//
//  Created by Viviana Leyva on 12/3/21.
//

/*
 This class is the controller for the profile information view. It is integrated to firebase to get information about the profile. The main use of this view is the logout view to logout the user out of the app.
 **/

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var LblName: UILabel!
    
    @IBOutlet weak var BtnLogOut: UIButton!
    
    var customer : Customer = Customer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BtnLogOut.layer.cornerRadius = 15
        
        getLoggedInCustomer()
    }
    
    
    @IBAction func btnLogOutClicked(_ sender: Any) {
        Utils.logoutUser()
        self.performSegue(withIdentifier: "ProfileToLoginSignUp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.destination is UnauthenticatedNavigationController {
                let resume = segue.destination as? UnauthenticatedNavigationController
                resume?.modalPresentationStyle = .fullScreen
            }
        }
    
    func getLoggedInCustomer() {
        let db = Firestore.firestore()
        let customerId = UserDefaults.standard.object(forKey: "LoggedInCustomerId")
        let docRef = db.collection("Customers").document(customerId as! String)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.customer = Customer(firebaseDictionary: document.data()!)
                self.refreshNameLabel()
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func refreshNameLabel() {
        LblName.text = customer.fullName
    }
    
}
