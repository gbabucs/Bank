//
//  TransactionListCell.swift
//  Bank
//
//  Created by ThunderFlash on 14/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit

class TransactionListCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var txnDescription: UILabel!
    @IBOutlet weak var txnAmount: UILabel!
    @IBOutlet weak var txnAccountNumber: UILabel!
}

// MARK: - Cell

extension TransactionListCell: Cell {
    
    func configure(for item: Transaction) {
        let amount = Amount.checkBalance(with: item.amount)
        
        self.txnDescription.text = item.descriptionField
        self.txnAmount.text = amount.sign + item.amount
        self.txnAmount.textColor = amount.color
    }
}
