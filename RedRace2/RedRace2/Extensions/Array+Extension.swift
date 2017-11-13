//
//  Array+Extension.swift
//  RedRace2
//
//  Created by Sandy Stehr on 13.11.17.
//  Copyright © 2017 Sandy Stehr. All rights reserved.
//

import Foundation

extension Array {
    func random() -> Element? {
        if self.isEmpty {
            return nil
        }
        let index = self.count.random()
        return self[index]
    }
}
