//
//  ViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var BtnSignUp: UIButton!
    @IBOutlet weak var BtnSignIn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        //if user is logged in, segue to product list view
        if UserDefaults.standard.object(forKey: "LoggedInEmail") != nil {
          //user logged in
            performSegue(withIdentifier: "HomePageToProductList", sender: nil)
        }
        BtnSignUp.layer.cornerRadius = 15
        BtnSignIn.layer.borderWidth = 1
        BtnSignIn.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        BtnSignIn.layer.cornerRadius = 15
        
    }
 
    

}

