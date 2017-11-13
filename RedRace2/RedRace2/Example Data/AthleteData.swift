//
//  AthleteData.swift
//  RedRace2
//
//  Created by Sandy Stehr on 13.11.17.
//  Copyright © 2017 Sandy Stehr. All rights reserved.
//

import UIKit

class AthleteData {
    var firstName = ""
    var lastName = ""
    var dob = Date()
    var gender = ""
    
    private let firstNames = ["Amaya", "Noe", "Julius", "Carolina", "Aria", "Meghan", "Braylon", "Celia", "Alijah", "Mathew", "Diego", "Arely", "Stacy", "Mareli", "Brendan", "Harrison", "Olive", "Litzy", "Deven", "Lilliana", "Liam", "Kenley", "Hana", "Devin", "Ali", "Judah", "Carlee", "Fletcher", "Maleah", "Jayla", "Beckham", "Leonidas", "Kyra", "Finnegan", "Genevieve", "Vivian", "Kristin", "Janet", "Alison", "Howard", "Frank", "Ignacio", "Elizabeth", "Zion", "Journey", "Vaughn", "Mateo", "Bridger", "Jaxson", "Mikayla"]
    private let lastNames = ["Bridges", "Winters", "Clements", "Roberts", "Gordon", "Yoder", "Romero", "Acevedo", "Becker", "Calderon", "Wu", "Cervantes", "Meza", "Stephens", "Hogan", "Robles", "Stokes", "Mckee", "Navarro", "Bradley", "Clayton", "Martin", "Harrell", "Hess", "Hamilton", "Cortez", "Nash", "Wright", "Sawyer", "Thornton", "Avila", "Gill", "Calhoun", "Warner", "Morales", "Bender", "Petty", "Cunningham", "Glenn", "Padilla", "Grant", "Hooper", "Marshall", "Barber", "Poole", "Carrillo", "Richardson", "Johnson", "Esparza", "Vang"]
    private let genderNames = ["maennlich", "weiblich"]
    
    init() {
        // Random name
        let isLower = arc4random_uniform(10) < 5
        var index = Int(arc4random_uniform(UInt32(firstNames.count)))
        let first = (isLower ? firstNames[index].lowercased() : firstNames[index])
        index = Int(arc4random_uniform(UInt32(lastNames.count)))
        let last = (isLower ? lastNames[index].lowercased() : lastNames[index])
        firstName = first
        lastName = last
        gender = genderNames [Int(arc4random_uniform(UInt32(genderNames.count)))].lowercased()
        // Random DOb
        dob =  Date().random(unit: Calendar.Component.year, from: -10, upto: -90)!
    }
}

