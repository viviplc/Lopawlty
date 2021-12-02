//
//  Customer+CoreDataProperties.swift
//  Lopawlty
//
//  Created by user194247 on 11/25/21.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var petType: String?
    @NSManaged public var province: String?

}

extension Customer : Identifiable {

}
