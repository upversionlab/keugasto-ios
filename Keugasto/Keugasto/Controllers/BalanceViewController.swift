//
//  BalanceViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/17/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class BalanceViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private weak var noCategoriesLabel: UILabel!
    @IBOutlet private weak var categoriesTableView: UITableView!

    private var categories : [Category]!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        categories = Category.getAllCategories()
    }

    // MARK: UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if categories.count > 0 {
            noCategoriesLabel.hidden = true
            categoriesTableView.hidden = false
            return categories.count
        } else {
            noCategoriesLabel.hidden = false
            categoriesTableView.hidden = true
            return 0
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categories[section]

        if category.expenses.count > 0 {
            return category.expenses.count
        } else {
            return 1
        }
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let category = categories[section]

        let cell = tableView.dequeueReusableCellWithIdentifier("Category") as! CategoryTableViewCell
        cell.nameLabel.text = category.name
        return cell
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let category = categories[indexPath.section]

        if category.expenses.count > 0 {
            let expense = category.expenses[indexPath.row]

            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle

            let cell = tableView.dequeueReusableCellWithIdentifier("Expense", forIndexPath: indexPath) as! ExpenseTableViewCell
            cell.nameLabel.text = expense.category.name
            cell.valueLabel.text = numberFormatter.stringFromNumber(expense.value)
            
            return cell
        } else {
            return tableView.dequeueReusableCellWithIdentifier("Empty Category")!
        }
    }

    // MARK: IBActions

    @IBAction func didClickOnMenu(sender: AnyObject) {
        let mainViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? MainViewController
        mainViewController?.didClickOnMenu()
    }

}
