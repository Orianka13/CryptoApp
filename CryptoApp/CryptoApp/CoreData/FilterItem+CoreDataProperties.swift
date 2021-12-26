//
//  FilterItem+CoreDataProperties.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 26.12.2021.
//
//

import Foundation
import CoreData


extension FilterItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FilterItem> {
        return NSFetchRequest<FilterItem>(entityName: "FilterItem")
    }

    @NSManaged public var itemId: String
    @NSManaged public var userId: UUID
    @NSManaged public var holder: User

}

extension FilterItem : Identifiable {

}
