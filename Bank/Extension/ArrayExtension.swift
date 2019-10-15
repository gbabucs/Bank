//
//  ArrayExtension.swift
//  Bank
//
//  Created by ThunderFlash on 14/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation

extension Array where Element: Dated {
   
    func groupedBy(dateComponents: Set<Calendar.Component>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
       
        let groupedByDateComponents = reduce(into: initial) { data, current in
            
            let components = Calendar.current.dateComponents(dateComponents, from: current.groupByDate)
            let date = Calendar.current.date(from: components)!
            let existing = data[date] ?? []
            
            data[date] = existing + [current]
        }
        
        return groupedByDateComponents
    }
}
