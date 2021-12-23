//
//  User+CoreDataProperties.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 23.12.2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var login: String
    @NSManaged public var password: String
    @NSManaged public var uid: UUID

}

extension User : Identifiable {

}
