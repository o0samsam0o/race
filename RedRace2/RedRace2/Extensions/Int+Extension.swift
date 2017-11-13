//
//  Int+Extension.swift
//  RedRace2
//
//  Created by Sandy Stehr on 13.11.17.
//  Copyright © 2017 Sandy Stehr. All rights reserved.
//

import Foundation

extension Int {
    func random() -> Int {
        let isNegative = self < 0
        let random = Int(arc4random_uniform(UInt32(abs(self)))) * (isNegative ? -1 : 1)
        return random
    }
}
