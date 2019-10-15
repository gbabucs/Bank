//
//  AccountDetailsModel.swift
//  Bank
//
//  Created by ThunderFlash on 13/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation

// MARK: - AccountDetailsModel
struct AccountDetailsModel: Codable {
    let account: String
    let balance: String
    let transactions: [Transaction]
    
    enum CodingKeys: String, CodingKey {

        case account = "account"
        case balance = "balance"
        case transactions = "transactions"
    }
}
