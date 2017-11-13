//
//  Athlete+CoreDataProperties.swift
//  RedRace2
//
//  Created by Sandy Stehr on 13.11.17.
//  Copyright © 2017 Sandy Stehr. All rights reserved.
//
//

import Foundation
import CoreData


extension Athlete {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Athlete> {
        return NSFetchRequest<Athlete>(entityName: "Athlete")
    }

    @NSManaged public var birthDate: NSDate?
    @NSManaged public var eMail: String?
    @NSManaged public var firstName: String?
    @NSManaged public var gender: String?
    @NSManaged public var lastName: String?
    @NSManaged public var weight: NSDecimalNumber?

}
