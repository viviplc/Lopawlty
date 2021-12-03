//
//  Utils.swift
//  Lopawlty
//
//  Created by user194247 on 12/3/21.
//

import Foundation
import UIKit
import CoreData

class Utils {
    
    static func isUserLoggedIn() -> Bool {
        if UserDefaults.standard.object(forKey: "LoggedInEmail") != nil {
            return true
        } else {
            return false
        }
    }
    
    static func logoutUser() {
        emptyCoreDataEntity(entity: "Cart")
        deleteUserDefaultField(key: "LoggedInCustomerId")
    }
    
    static func emptyCartInCoreData() {
        emptyCoreDataEntity(entity: "Cart")
    }
    
    static func validateTextField(txtLabel : UITextField) -> Bool {
        if let text = txtLabel.text, !text.isEmpty
        {
            return true
        } else {
            return false
        }
    }
    
    static func validateTextFieldWithExactLength(txtLabel : UITextField, len : Int) -> Bool {
        if validateTextField(txtLabel: txtLabel) {
            return txtLabel.text!.count == len
        } else {
            return false
        }
    }
    
    static func validateTextFieldWithMinLen(txtLabel : UITextField, min : Int) -> Bool {
        if validateTextField(txtLabel: txtLabel) {
            return txtLabel.text!.count >= min
        } else {
            return false
        }
    }
    
    static func validateTextFieldWithMaxLen(txtLabel : UITextField, max : Int) -> Bool {
        if validateTextField(txtLabel: txtLabel) {
            return txtLabel.text!.count <= max
        } else {
            return false
        }
    }
    
    static func validateTextFieldWithMinMaxLen(txtLabel : UITextField, min : Int, max : Int) -> Bool {
        if validateTextField(txtLabel: txtLabel) {
            return txtLabel.text!.count >= min && txtLabel.text!.count <= max
        } else {
            return false
        }
    }
    
    static func validateTextFieldAsNumeric(txtLabel : UITextField) -> Bool {
        //below code to check if text is number taken from https://stackoverflow.com/a/60470348
        let numbersSet = CharacterSet(charactersIn: "0123456789")

        let textCharacterSet = CharacterSet(charactersIn: txtLabel.text!)

        if textCharacterSet.isSubset(of: numbersSet) {
            return true
        } else {
            return false
        }
    }
    
    static func deleteUserDefaultField(key : String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func alert(message: String, viewController : UIViewController) {
        //below code for alert taken from https://stackoverflow.com/a/24022696
        let alert = UIAlertController(title: "Invalid Form", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    //emptyCoreDataEntity function was taken from https://stackoverflow.com/questions/28780862/use-functions-from-other-files-in-swift-xcode
    
    static func emptyCoreDataEntity(entity: String)
    {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false

        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Deleted all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
}
