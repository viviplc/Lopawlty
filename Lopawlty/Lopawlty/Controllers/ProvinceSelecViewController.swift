//
//  ProvinceSelecViewController.swift
//  Lopawlty
//
//  Created by user193926 on 11/11/21.
//

import UIKit
import CoreData

class ProvinceSelecViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var BtnSelectProv: UIButton!
    
    var provinces: [String] = []
 
    var selectedProvince : String = ""
    
    var loggedInCustomer : Customer = Customer()
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        BtnSelectProv.layer.cornerRadius = 15
        
        provinces = ["Alberta","British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador","Nova Scotia","Ontario","Prince Edward Island", "Quebec", "Saskatchewan"]
        
        setLoggedInCustomer()
        
        print("logged in customer is \(loggedInCustomer.name)")
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return provinces.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return provinces[row]
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedProvince = provinces[row]
    }
    
    func setLoggedInCustomer() {
        do {
        let request = Customer.fetchRequest() as NSFetchRequest<Customer>
        guard let email = UserDefaults.standard.string(forKey: "LoggedInEmail") else {
            return
        }
        let pred = NSPredicate(format: "email = %@",email)
        request.predicate = pred
        let user = try managedContext.fetch(request)
        loggedInCustomer = user[0]
        } catch {
            print("Error while signing in")
        }
        
    }
 

    @IBAction func selectButtonClicked(_ sender: Any) {
        loggedInCustomer.province = selectedProvince
        do{
            try self.managedContext.save()
            performSegue(withIdentifier: "ProvinceSelectToProducts", sender: nil)
        } catch {
            print("Error in updating data")
        }
    }
    
   

}
