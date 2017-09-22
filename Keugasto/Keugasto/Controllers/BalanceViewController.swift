//
//  BalanceViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/17/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class BalanceViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet fileprivate weak var noCategoriesLabel: UILabel!
    @IBOutlet fileprivate weak var categoriesTableView: UITableView!

    fileprivate var categories : [Category]!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        categories = Category.getAllCategories()
    }

    // MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        if categories.count > 0 {
            noCategoriesLabel.isHidden = true
            categoriesTableView.isHidden = false
            return categories.count
        } else {
            noCategoriesLabel.isHidden = false
            categoriesTableView.isHidden = true
            return 0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categories[section]

        if category.expenses.count > 0 {
            return category.expenses.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let category = categories[section]

        let cell = tableView.dequeueReusableCell(withIdentifier: "Category") as! CategoryTableViewCell
        cell.nameLabel.text = category.name
        return cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.section]

        if category.expenses.count > 0 {
            let expense = category.expenses[indexPath.row]

            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.currency

            let cell = tableView.dequeueReusableCell(withIdentifier: "Expense", for: indexPath) as! ExpenseTableViewCell
            cell.nameLabel.text = expense.category.name
            cell.valueLabel.text = numberFormatter.string(from: expense.value! as NSNumber)
            
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "Empty Category")!
        }
    }

    // MARK: IBActions

    @IBAction func didClickOnMenu(_ sender: AnyObject) {
        let mainViewController = UIApplication.shared.keyWindow?.rootViewController as? MainViewController
        mainViewController?.didClickOnMenu()
    }

}
