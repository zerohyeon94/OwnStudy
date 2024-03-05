//
//  UserInfoEntity+CoreDataProperties.swift
//  OwnStudy
//
//  Created by 조영현 on 3/4/24.
//
//

import Foundation
import CoreData


extension UserInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfoEntity> {
        return NSFetchRequest<UserInfoEntity>(entityName: "UserInfoEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var password: String?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var goal: [String]?

}

extension UserInfoEntity : Identifiable {

}
