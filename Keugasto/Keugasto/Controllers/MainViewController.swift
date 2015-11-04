//
//  MainViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/3/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {

    @IBOutlet private weak var noExpensesLabel: UILabel!
    @IBOutlet private weak var expensesTableView: UITableView!

    @IBOutlet private weak var menuContainerView: UIView!
    @IBOutlet private weak var menuBackgroundView: UIView!
    @IBOutlet private weak var menuConstraint: NSLayoutConstraint!

    private var expenses : [Expense]?

    // MARK: UITableViewDataSource

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Expense", forIndexPath: indexPath) as! ExpenseTableViewCell
        cell.nameLabel.text = expenses![indexPath.row].name
        cell.valueLabel.text = String(format: "R$ %.02f", expenses![indexPath.row].value)
        return cell
    }

    // MARK: Add action

    @IBAction func didClickOnAdd(sender: AnyObject) {
        if (expenses == nil) {
            expenses = []
        }

        let expense = Expense()
        expense.name = String(format: "Expense %d", expenses!.count)
        expense.value = Float(expenses!.count)
        expenses!.append(expense)

        expensesTableView.reloadData()
    }

    // MARK: Menu actions

    @IBAction func didClickOnMenu(sender: AnyObject) {
        self.view.layoutIfNeeded()

        if menuConstraint.constant > 0 {
            menuConstraint.constant = 0
            menuBackgroundView.hidden = true
        } else {
            menuConstraint.constant = menuContainerView.frame.width
            menuBackgroundView.hidden = false
        }

        UIView.animateWithDuration(0.5) {() -> Void in
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func didClickOutsideMenu(sender: AnyObject) {
        self.didClickOnMenu(sender)
    }

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

}

