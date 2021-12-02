//
//  Product+CoreDataProperties.swift
//  Lopawlty
//
//  Created by user194247 on 11/25/21.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var brand: String?
    @NSManaged public var category: NSObject?
    @NSManaged public var imageUrl: NSObject?

}

extension Product : Identifiable {

}
