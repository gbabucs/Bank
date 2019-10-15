//
//  TransactionService.swift
//  Bank
//
//  Created by ThunderFlash on 14/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation

class TransactionSerivice {
    
    //--------------------------------------------------------------------------
    // MARK: - Typealias
    //--------------------------------------------------------------------------
    
    typealias ResponseHandler = (_ responseData: Data? ,_ error: Error?) -> ()
    
    //--------------------------------------------------------------------------
    // MARK: - readJsonFile
    //--------------------------------------------------------------------------
    
    /// Get list of transaction request  using  `readJsonFile`
    ///
    /// - Parameters:
    ///   - completion:    The `ResponseHandler` value
    
    func readJsonFile(completion: @escaping ResponseHandler) {
        let bundle = Bundle(for: TransactionSerivice.self)
        
        if let path = bundle.path(forResource: "transactions", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                completion(data, nil)
            } catch (let error) {
                completion(nil, error)
            }
        }
        
        completion(nil, AppError.dataError)
    }
}
