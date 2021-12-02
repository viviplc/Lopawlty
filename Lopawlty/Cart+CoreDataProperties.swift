//
//  Cart+CoreDataProperties.swift
//  Lopawlty
//
//  Created by user194247 on 11/25/21.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var customerEmail: String?
    @NSManaged public var products: Product?

}

extension Cart : Identifiable {

}
