//
//  TransactionDetailViewController.swift
//  Bank
//
//  Created by ThunderFlash on 15/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit

class TransactionDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var txnDescription: UILabel!
    @IBOutlet weak var txnAmount: UILabel!
    @IBOutlet weak var txnAccountNumber: UILabel!
    @IBOutlet weak var txnDate: UILabel!
    @IBOutlet weak var txnId: UILabel!
    @IBOutlet weak var customView: UIView!
    
    // MARK: - Properties
    
    var transaction: Transaction?
    var tapGesture = UITapGestureRecognizer()
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateView()
        self.handleGesture()
    }
    
    // MARK: - Helpers
    
    func updateView() {
        guard let transaction = transaction else { return }
        
        let amount = Amount.checkBalance(with: transaction.amount)
        
        self.txnId.text = transaction.id
        self.txnDescription.text = transaction.descriptionField
        self.txnAmount.text = amount.sign + transaction.amount
        self.txnDate.text = transaction.displayDate
        self.txnAccountNumber.text = transaction.otherAccount
        
        self.txnAmount.textColor = amount.color
    }
    
    func handleGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        customView.addGestureRecognizer(tapGesture)
        customView.isUserInteractionEnabled = true
    }
    
    @objc
    func viewTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - IBAction
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
