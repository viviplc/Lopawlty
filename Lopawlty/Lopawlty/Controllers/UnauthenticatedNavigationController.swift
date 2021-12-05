//
//  UnauthenticatedNavigationController.swift
//  Lopawlty
//
//  Created by Dunumalage Romeno Fernando on 12/3/21.
//

/**
 Navigation controller for the initial view of the app. It will segue to the the tab bar controller if the user has already logged in.
 */

import UIKit

class UnauthenticatedNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(Utils.isUserLoggedIn()) {
            //UnauthenticatedNavToTabBar
            self.performSegue(withIdentifier: "UnauthenticatedNavToTabBar", sender: self)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
