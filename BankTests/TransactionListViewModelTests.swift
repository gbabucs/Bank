//
//  TransactionListViewModelTests.swift
//  BankTests
//
//  Created by ThunderFlash on 15/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import XCTest

class TransactionListViewModelTests: XCTestCase {
    
    var viewModel: TransactionListViewModel!
    
    override func setUp() {
        super.setUp()
        self.viewModel = TransactionListViewModel()
    }
    
    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }
    
    func testViewModelAccountDetailsModelIsNotEmpty() {
        let response = valuesFromJSON(name: "transactions")
        
        XCTAssertEqual(self.viewModel.accountDetailsModel?.account, response?.account, "Expected both viewModel and model have same values")
    }
    
    func testViewModelTransactionIsNotEmpty() {
        let response = valuesFromJSON(name: "transactions")
        
        XCTAssertEqual(self.viewModel.accountDetailsModel?.transactions.count, response?.transactions.count, "Expected both viewModel and respoonse have same data")
    }
    
    func testAccountDetailModelIsEmpty() {
        let accountDetailsModel = AccountDetailsModel(account: "", balance: "", transactions: [])
        
        viewModel.accountDetailsModel = accountDetailsModel
        
        XCTAssertEqual(self.viewModel.accountDetailsModel?.account, accountDetailsModel.account, "Expected both have empty account name")
        XCTAssertEqual(self.viewModel.accountDetailsModel?.balance, accountDetailsModel.balance, "Expected both have empty balance")
        XCTAssertEqual(self.viewModel.accountDetailsModel?.transactions.count, accountDetailsModel.transactions.count, "Expected both have empty transactions")
    }
    
    
    func valuesFromJSON(name: String) -> AccountDetailsModel? {
        var response: AccountDetailsModel?
        
        guard let data = FileManager.readJsonFile(forResource: name)
            else {
                XCTAssertFalse(false, "Can't get data from transactions.json")
                return response
        }
        
        guard let accountDetailsModel = DataAdapter.shared.processData(type: AccountDetailsModel.self, response: data)
            else {
                XCTAssertFalse(false, "Can't parse json")
                return response
        }
        
        response = accountDetailsModel
        
        return response
    }
}

extension FileManager {
    static func readJsonFile(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: TransactionListViewModelTests.self)
        
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                return data
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

