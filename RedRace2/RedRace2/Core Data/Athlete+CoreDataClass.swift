//
//  Athlete+CoreDataClass.swift
//  RedRace2
//
//  Created by Sandy Stehr on 13.11.17.
//  Copyright © 2017 Sandy Stehr. All rights reserved.
//
//

import Foundation
import CoreData


public class Athlete: NSManagedObject {
    var age: Int {
        if let dob = birthDate as Date? {
            return Calendar.current.dateComponents([.year], from: dob, to: Date()).year!
        }
        return 0
    }
}
