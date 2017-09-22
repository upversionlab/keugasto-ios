//
//  ExpensesViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/10/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class ExpensesViewController: BaseViewController, UITableViewDataSource, AddExpenseDelegate {

    @IBOutlet fileprivate weak var noExpensesLabel: UILabel!
    @IBOutlet fileprivate weak var expensesTableView: UITableView!

    fileprivate var expenses : [Expense]!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        expenses = Expense.getAllExpenses()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add Expense Segue" {
            let navigationController = segue.destination as! UINavigationController
            let addExpenseViewController = navigationController.topViewController as! AddExpenseViewController
            addExpenseViewController.delegate = self
        }
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expenses.count > 0 {
            noExpensesLabel.isHidden = true
            expensesTableView.isHidden = false
            return expenses.count
        } else {
            noExpensesLabel.isHidden = false
            expensesTableView.isHidden = true
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = expenses[indexPath.row]

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency

        let cell = tableView.dequeueReusableCell(withIdentifier: "Expense", for: indexPath) as! ExpenseTableViewCell
        cell.nameLabel.text = expense.category.name
        cell.valueLabel.text = numberFormatter.string(from: expense.value! as NSNumber)

        return cell
    }

    // MARK: AddExpenseDelegate

    func didAddExpense(_ expense: Expense) {
        expenses.append(expense)
        expensesTableView.reloadData()
    }

    // MARK: IBActions

    @IBAction func didClickOnMenu(_ sender: AnyObject) {
        let mainViewController = UIApplication.shared.keyWindow?.rootViewController as? MainViewController
        mainViewController?.didClickOnMenu()
    }
    
}

