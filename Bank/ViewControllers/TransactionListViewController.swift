//
//  TransactionListViewController.swift
//  Bank
//
//  Created by ThunderFlash on 13/10/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit

class TransactionListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    
    // MARK: - Properties
    
    private var detailsTransitioningDelegate: InteractiveModalTransitioningDelegate!
    let viewModel = TransactionListViewModel()
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.tableView.tableFooterView = UIView.init()
    }
    
    // MARK: - Helpers
    
    func setupView() {
        self.accountNumber.text = viewModel.accountDetailsModel?.account
        self.balance.text = "€\(String(describing: viewModel.accountDetailsModel?.balance ?? "0.00"))"
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Navigation
    //--------------------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == UIStoryboardSegue.Name.identifier ,
            let transactionDetailViewController = segue.destination as? TransactionDetailViewController,
            let indexPath = sender as? IndexPath
            else { return }
        
        detailsTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self, to: transactionDetailViewController)
        transactionDetailViewController.modalPresentationStyle = .custom
        transactionDetailViewController.transitioningDelegate = detailsTransitioningDelegate
        
        let transaction  = viewModel.item(at: indexPath)
        
        transactionDetailViewController.transaction = transaction
        
        guard let selectedCell = tableView.indexPathForSelectedRow else { return }
        
        tableView.deselectRow(at: selectedCell, animated: false)
    }
}

// MARK: UITableViewDataSource

extension TransactionListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(with: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionListCell.reuseIdentifier, for: indexPath) as? TransactionListCell
            else { return UITableViewCell() }
        
        viewModel.update(cell, at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(with: section)
    }
}

// MARK: UITableViewDelegate

extension TransactionListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: UIStoryboardSegue.Name.identifier, sender: indexPath)
    }
}


