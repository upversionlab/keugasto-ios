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
    @objc optional func didPickCategory(_ category: Category?)
    @objc optional func didCancelPickCategory()
}

class CategoryPickerViewController: BaseViewController, AddCategoryDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var delegate: CategoryPickerDelegate?

    @IBOutlet fileprivate weak var noCategoriesLabel: UILabel!
    @IBOutlet fileprivate weak var categoryPickerView: UIPickerView!

    fileprivate var categories: [Category]!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        categories = Category.getAllCategories()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if categories.count > 0 {
            noCategoriesLabel.isHidden = true
            categoryPickerView.isHidden = false
        } else {
            noCategoriesLabel.isHidden = false
            categoryPickerView.isHidden = true
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add New Category Segue" {
            let navigationController = segue.destination as! UINavigationController
            let addCategoryViewController = navigationController.topViewController as! AddCategoryViewController
            addCategoryViewController.delegate = self
        }
    }

    // MARK: AddCategoryDelegate

    func didAddCategory(_ category: Category) {
        categories.append(category)
        categoryPickerView.reloadAllComponents()
    }

    // MARK: UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if categories.count > 0 {
            noCategoriesLabel.isHidden = true
            categoryPickerView.isHidden = false
            return categories.count
        } else {
            noCategoriesLabel.isHidden = false
            categoryPickerView.isHidden = true
            return 0
        }
    }

    // MARK: UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }

    // MARK: IBActions

    @IBAction func didClickOk(_ sender: AnyObject) {
        var category: Category? = nil

        let selectedCategoryIndex = categoryPickerView.selectedRow(inComponent: 0)
        if 0 <= selectedCategoryIndex && selectedCategoryIndex < categories.count {
            category = categories[selectedCategoryIndex]
        }

        dismiss(animated: true) { () -> Void in
            self.delegate?.didPickCategory?(category)
        }
    }

    @IBAction func didClickOutside(_ sender: AnyObject) {
        dismiss(animated: true) { () -> Void in
            self.delegate?.didCancelPickCategory?()
        }
    }

}
