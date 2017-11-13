//
//  AthleteData.swift
//  RedRace2
//
//  Created by Sandy Stehr on 13.11.17.
//  Copyright © 2017 Sandy Stehr. All rights reserved.
//

/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class AthleteData {
    var name = ""
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
        name = first + " " + last
        // Random DOb
        dob = Date().random(unit: Calendar.Component.year, from: -10, upto: -90)!
    }
}

