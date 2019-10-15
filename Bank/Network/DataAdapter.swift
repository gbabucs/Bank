//
//  DataController.swift
//  Bank
//
//  Created by ThunderFlash on 14/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation

class DataAdapter {
    
    static let shared = DataAdapter()
    
    //--------------------------------------------------------------------------
    // MARK: - Typealias
    //--------------------------------------------------------------------------
    
    typealias GetCompletionHandler = (AccountDetailsModel?, AppError?) -> ()
    
    //--------------------------------------------------------------------------
    // MARK: - Functions
    //--------------------------------------------------------------------------
    
    /// Get Account details  response using  `AccountDetailsModel`  to
    /// the provided `destination` using the `method`, `parameters`
    ///
    /// - Parameters:
    ///     - completion:    The `GetCompletionHandler` value
    
    func fetchTransactions(completion: @escaping GetCompletionHandler) {
        let service = TransactionSerivice()
        
        self.fetchData(from: service, type: AccountDetailsModel.self, completion: completion)
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Private functions
    //--------------------------------------------------------------------------
    
    private func fetchData<T: Codable>(from request: TransactionSerivice, type: T.Type , completion: @escaping (_ response: T?, _ error: AppError?) -> Void) {
        request.readJsonFile { response, error in
            var appError: AppError?
            let result = self.processData(type: type, response: response)
            
            if let _ = error {
                appError = AppError.dataError
            }
            
            completion(result, appError)
        }
    }
    
    func processData<T: Codable>(type: T.Type, response: Data?) -> T? {
        var result: T? = nil
        
        if let jsondata = response {
            do {
                let object = try JSONDecoder().decode(T.self, from: jsondata)
                
                result = object
                
            } catch let jsonError {
                print("Error decoding Json Questons", jsonError)
            }
        }
        
        return result
    }
}
