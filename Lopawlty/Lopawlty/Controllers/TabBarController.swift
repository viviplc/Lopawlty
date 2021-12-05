//
//  TabBarController.swift
//  Lopawlty
//
//  Created by Dunumalage Romeno Fernando on 12/3/21.
//

/**
Tab bar controller for home, orders and profile views
 */

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
                let rootView = self.viewControllers![self.selectedIndex] as! UINavigationController
                rootView.popToRootViewController(animated: false)
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
