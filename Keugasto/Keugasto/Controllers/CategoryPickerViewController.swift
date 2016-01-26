//
//  CategoryPickerViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 12/1/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

@objc
protocol CategoryPickerDelegate {
    optional func didPickCategory(category: Category?)
    optional func didCancelPickCategory()
}

class CategoryPickerViewController: BaseViewController, AddCategoryDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var delegate: CategoryPickerDelegate?

    @IBOutlet private weak var noCategoriesLabel: UILabel!
    @IBOutlet private weak var categoryPickerView: UIPickerView!

    private var categories: [Category]!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        categories = Category.getAllCategories()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if categories.count > 0 {
            noCategoriesLabel.hidden = true
            categoryPickerView.hidden = false
        } else {
            noCategoriesLabel.hidden = false
            categoryPickerView.hidden = true
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Add New Category Segue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let addCategoryViewController = navigationController.topViewController as! AddCategoryViewController
            addCategoryViewController.delegate = self
        }
    }

    // MARK: AddCategoryDelegate

    func didAddCategory(category: Category) {
        categories.append(category)
        categoryPickerView.reloadAllComponents()
    }

    // MARK: UIPickerViewDataSource

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if categories.count > 0 {
            noCategoriesLabel.hidden = true
            categoryPickerView.hidden = false
            return categories.count
        } else {
            noCategoriesLabel.hidden = false
            categoryPickerView.hidden = true
            return 0
        }
    }

    // MARK: UIPickerViewDelegate

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }

    // MARK: IBActions

    @IBAction func didClickOk(sender: AnyObject) {
        var category: Category? = nil

        let selectedCategoryIndex = categoryPickerView.selectedRowInComponent(0)
        if 0 <= selectedCategoryIndex && selectedCategoryIndex < categories.count {
            category = categories[selectedCategoryIndex]
        }

        dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didPickCategory?(category)
        }
    }

    @IBAction func didClickOutside(sender: AnyObject) {
        dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didCancelPickCategory?()
        }
    }

}
