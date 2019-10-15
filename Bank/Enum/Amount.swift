//
//  Amount.swift
//  Bank
//
//  Created by ThunderFlash on 15/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation
import UIKit

enum Amount {
    case positive
    case negative
    
    var color: UIColor {
        switch self {
        case .positive: return .green
        case .negative: return .red
        }
    }
    
    var sign: String {
        return self == .positive ? "+" : ""
    }
    
    static func checkBalance(with amount: String) -> Amount {
        let transferAmount = Double(amount) ?? 0
        
        return transferAmount > 0 ? .positive : .negative
    }
    
}
