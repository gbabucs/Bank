//
//  Transaction.swift
//  Bank
//
//  Created by ThunderFlash on 13/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation

// MARK: - Transaction
struct Transaction: Codable {
    let amount : String
    let dateField : String
    let descriptionField : String
    let id : String
    let otherAccount : String
    
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case dateField = "date"
        case descriptionField = "description"
        case id = "id"
        case otherAccount = "otherAccount"
    }
}

extension Transaction {
    var responseDate: Date {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        //"date" : "2018-05-14T08:19:00Z"
        
        guard let date = formatter.date(from: dateField)
            else { return Date() }
        
        return date
    }
    
    var displayDate: String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "d MMM yyyy"
    
        return formatter.string(from: responseDate)
    }
}

extension Transaction: Dated {
    var groupByDate: Date {
        return responseDate
    }
}

extension Transaction: Comparable {
    static func < (lhs: Transaction, rhs: Transaction) -> Bool {
         return lhs.groupByDate < rhs.groupByDate
    }
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.groupByDate == rhs.groupByDate
    }
}
