//
//  CategoriesViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 12/1/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource, AddCategoryDelegate {

    @IBOutlet private weak var noCategoriesLabel: UILabel!
    @IBOutlet private weak var categoriesTableView: UITableView!

    private var categories: [Category]!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        categories = Category.getAllCategories()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Add Category Segue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let addCategoryViewController = navigationController.topViewController as! AddCategoryViewController
            addCategoryViewController.delegate = self
        }
    }

    // MARK: UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Category", forIndexPath: indexPath) as! CategoryTableViewCell
        cell.nameLabel.text = categories[indexPath.row].name
        return cell
    }

    // MARK: AddCategoryDelegate

    func didAddCategory(category: Category) {
        categories.append(category)
        categoriesTableView.reloadData()
    }

    // MARK: IBActions

    @IBAction func didClickOnMenu(sender: AnyObject) {
        let mainViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? MainViewController
        mainViewController?.didClickOnMenu()
    }

}