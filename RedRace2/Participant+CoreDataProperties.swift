//
//  Participant+CoreDataProperties.swift
//  RedRace2
//
//  Created by Sandy Stehr on 06.11.17.
//  Copyright © 2017 Sandy Stehr. All rights reserved.
//
//

import Foundation
import CoreData


extension Participant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Participant> {
        return NSFetchRequest<Participant>(entityName: "Participant")
    }

    @NSManaged public var participantEndTime: NSDate?
    @NSManaged public var participantID: Int16
    @NSManaged public var participantStartTime: NSDate?
    @NSManaged public var group: Group?

}
