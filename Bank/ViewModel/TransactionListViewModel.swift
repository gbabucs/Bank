//
//  TransactionListViewModel.swift
//  Bank
//
//  Created by ThunderFlash on 14/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation

class TransactionListViewModel {
    
    var sections = [Section]()
    var accountDetailsModel: AccountDetailsModel?
    
    var numberOfSections: Int {
        return sections.count
    }
    
    private var data: [Date:[Transaction]] = [:]
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "d MMM yyyy"
        
        return formatter
    }()
    
    init() {
        self.getTransaction()
    }
    
    func groupByDate() {
        guard let tranactions = self.accountDetailsModel?.transactions,
            tranactions.count > 0
            else { return }
        
        let result = tranactions.groupedBy(dateComponents: [.year, .month, .day])
        
        data = result
        makeDataSource()
    }
    
    func getTransaction() {
        DataAdapter.shared.fetchTransactions { response, error in
            if let response = response {
                self.accountDetailsModel = response
                self.groupByDate()
            }
        }
    }
    
    func makeDataSource() {
        var result = [Section]()
        
        for (key, value) in data {
            let sortedTransaction = value.sorted(by: >)
            
            result.append(Section(date: key, tranactions: sortedTransaction))
        }
        
        sections = result.sorted(by: >)
    }
    
    func numberOfRowsInSection(with section: Int) -> Int {
        return sections[section].tranactions.count
    }
    
    func item(at indexPath: IndexPath) -> Transaction {
        return sections[indexPath.section].tranactions[indexPath.row]
    }
    
    func titleForHeaderInSection(with section: Int) -> String {
        let date = sections[section].date
        
        return dateFormatter.string(from: date)
    }
    
    func update(_ cell: TransactionListCell, at indexPath: IndexPath) {
        let transaction = item(at: indexPath)
        
        cell.configure(for: transaction)
    }
    
}
