//
//  ExpensesViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/10/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class ExpensesViewController: UIViewController, UITableViewDataSource, AddExpenseDelegate {

    @IBOutlet private weak var noExpensesLabel: UILabel!
    @IBOutlet private weak var expensesTableView: UITableView!

    private var expenses : [Expense]!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        expenses = Expense.getAllExpenses()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Add Expense Segue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let addExpenseViewController = navigationController.topViewController as! AddExpenseViewController
            addExpenseViewController.delegate = self
        }
    }

    // MARK: UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expenses != nil && expenses!.count > 0 {
            noExpensesLabel.hidden = true
            expensesTableView.hidden = false
            return expenses!.count
        } else {
            noExpensesLabel.hidden = false
            expensesTableView.hidden = true
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let expense = expenses![indexPath.row]

        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle

        let cell = tableView.dequeueReusableCellWithIdentifier("Expense", forIndexPath: indexPath) as! ExpenseTableViewCell
        cell.nameLabel.text = expense.category.name
        cell.valueLabel.text = numberFormatter.stringFromNumber(expense.value)

        return cell
    }

    // MARK: AddExpenseDelegate

    func didAddExpense(expense: Expense) {
        if expenses == nil {
            expenses = []
        }
        expenses?.append(expense)

        expensesTableView.reloadData()
    }

    // MARK: IBActions

    @IBAction func didClickOnMenu(sender: AnyObject) {
        let mainViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? MainViewController
        mainViewController?.didClickOnMenu()
    }
    
}

