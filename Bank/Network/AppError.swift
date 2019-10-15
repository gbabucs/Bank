//
//  AppError.swift
//  Bank
//
//  Created by ThunderFlash on 14/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation

public enum AppError: Error {
    case networkError
    case dataError
}

extension AppError: LocalizedError {
    
    var title: String {
        switch self {
        case .networkError:
            return "No Internet Connection"
        case .dataError:
            return "Server problem"
        }
    }
    
    var message: String {
        return "Please try again later"
    }
}
