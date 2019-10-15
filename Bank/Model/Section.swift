//
//  Section.swift
//  Bank
//
//  Created by ThunderFlash on 15/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation

struct Section {
    let date : Date
    let tranactions : [Transaction]
}

extension Section: Comparable {
    static func < (lhs: Section, rhs: Section) -> Bool {
         return lhs.date < rhs.date
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.date == rhs.date
    }
}
