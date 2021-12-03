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
    
    static func validateTextFieldWithMin(txtLabel : UITextField, min : Int) -> Bool {
        if validateTextField(txtLabel: txtLabel) {
            return txtLabel.text!.count >= min
        } else {
            return false
        }
    }
    
    static func validateTextFieldWithMax(txtLabel : UITextField, max : Int) -> Bool {
        if validateTextField(txtLabel: txtLabel) {
            return txtLabel.text!.count <= max
        } else {
            return false
        }
    }
    
    static func validateTextFieldWithMinMax(txtLabel : UITextField, min : Int, max : Int) -> Bool {
        if validateTextField(txtLabel: txtLabel) {
            return txtLabel.text!.count >= min && txtLabel.text!.count <= max
        } else {
            return false
        }
    }
    
    static func deleteUserDefaultField(key : String) {
        UserDefaults.standard.removeObject(forKey: key)
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
