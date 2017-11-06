//
//  Race+CoreDataProperties.swift
//  RedRace2
//
//  Created by Sandy Stehr on 06.11.17.
//  Copyright © 2017 Sandy Stehr. All rights reserved.
//
//

import Foundation
import CoreData


extension Race {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Race> {
        return NSFetchRequest<Race>(entityName: "Race")
    }

    @NSManaged public var raceEndTime: NSDate?
    @NSManaged public var raceName: String?
    @NSManaged public var raceStartTime: NSDate?
    @NSManaged public var startingGroups: NSSet?

}

// MARK: Generated accessors for startingGroups
extension Race {

    @objc(addStartingGroupsObject:)
    @NSManaged public func addToStartingGroups(_ value: Group)

    @objc(removeStartingGroupsObject:)
    @NSManaged public func removeFromStartingGroups(_ value: Group)

    @objc(addStartingGroups:)
    @NSManaged public func addToStartingGroups(_ values: NSSet)

    @objc(removeStartingGroups:)
    @NSManaged public func removeFromStartingGroups(_ values: NSSet)

}
