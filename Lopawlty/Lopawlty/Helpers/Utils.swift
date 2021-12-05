//
//  Utils.swift
//  Lopawlty
//
//  Created by Dunumalage Romeno Fernando on 12/3/21.
//

/**
 This class has static helper functions that are used throughout our app for validation of text fields, presenting a common alert view, checking if user is logging in, logging out the user etc.
 */

import Foundation
import UIKit
import CoreData

class Utils {
    
    //function that returns if a user is logged into app or not
    static func isUserLoggedIn() -> Bool {
        if UserDefaults.standard.object(forKey: "LoggedInCustomerId") != nil {
            return true
        } else {
            return false
        }
    }
    
    //function to logout user from the app
    static func logoutUser() {
        emptyCartInCoreData()
        deleteUserDefaultField(key: "LoggedInCustomerId")
    }
    
    //function to empty cart data model in core data
    static func emptyCartInCoreData() {
        //code taken from https://www.advancedswift.com/batch-delete-everything-core-data-swift/ to batch delete core data
        var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        // Get a reference to a NSPersistentStoreCoordinator
        let storeContainer =
            persistentContainer.persistentStoreCoordinator

        // Delete each existing persistent store
        for store in storeContainer.persistentStores {
            do {
            try storeContainer.destroyPersistentStore(
                at: store.url!,
                ofType: store.type,
                options: nil
            )
            } catch {
                print("error")
            }
        }

        // Re-create the persistent container
        persistentContainer = NSPersistentContainer(
            name: "Lopawlty" // the name of
            // a .xcdatamodeld file
        )

        // Calling loadPersistentStores will re-create the
        // persistent stores
        persistentContainer.loadPersistentStores {
            (store, error) in
            // Handle errors
        }
    }
    
    //function to validate a text field
    static func validateTextField(txtLabel : UITextField) -> Bool {
        if let text = txtLabel.text, !text.isEmpty
        {
            return true
        } else {
            return false
        }
    }
    
    //function to validate a text field to check if it exactly equal to specified legnth
    static func validateTextFieldWithExactLength(txtLabel : UITextField, len : Int) -> Bool {
        if validateTextField(txtLabel: txtLabel) {
            return txtLabel.text!.count == len
        } else {
            return false
        }
    }
    
    //function to validate a text field to check if it greater than a specified legnth
    static func validateTextFieldWithMinLen(txtLabel : UITextField, min : Int) -> Bool {
        if validateTextField(txtLabel: txtLabel) {
            return txtLabel.text!.count >= min
        } else {
            return false
        }
    }
    
    //function to validate a text field to check if it less than a specified legnth
    static func validateTextFieldWithMaxLen(txtLabel : UITextField, max : Int) -> Bool {
        if validateTextField(txtLabel: txtLabel) {
            return txtLabel.text!.count <= max
        } else {
            return false
        }
    }
    
    //function to validate a text field to check if it greater than and less a specified legnth
    static func validateTextFieldWithMinMaxLen(txtLabel : UITextField, min : Int, max : Int) -> Bool {
        if validateTextField(txtLabel: txtLabel) {
            return txtLabel.text!.count >= min && txtLabel.text!.count <= max
        } else {
            return false
        }
    }
    
    //function to validate a text field to check if it is a number
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
    
    //function to delete a user default by key
    static func deleteUserDefaultField(key : String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    //function to simplify presenting an alert to the user
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
    
    //function to empty core data
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
