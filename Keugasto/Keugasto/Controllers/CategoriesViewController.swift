//
//  CategoriesViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 12/1/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class CategoriesViewController: BaseViewController, UITableViewDataSource, AddCategoryDelegate {

    @IBOutlet fileprivate weak var noCategoriesLabel: UILabel!
    @IBOutlet fileprivate weak var categoriesTableView: UITableView!

    fileprivate var categories: [Category]!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        categories = Category.getAllCategories()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add Category Segue" {
            let navigationController = segue.destination as! UINavigationController
            let addCategoryViewController = navigationController.topViewController as! AddCategoryViewController
            addCategoryViewController.delegate = self
        }
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath) as! CategoryTableViewCell
        cell.nameLabel.text = categories[indexPath.row].name
        return cell
    }

    // MARK: AddCategoryDelegate

    func didAddCategory(_ category: Category) {
        categories.append(category)
        categoriesTableView.reloadData()
    }

    // MARK: IBActions

    @IBAction func didClickOnMenu(_ sender: AnyObject) {
        let mainViewController = UIApplication.shared.keyWindow?.rootViewController as? MainViewController
        mainViewController?.didClickOnMenu()
    }

}
