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
    optional func didPickCategory(category: Category)
    optional func didCancelPickCategory()
}

class CategoryPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var delegate: CategoryPickerDelegate?

    @IBOutlet private weak var categoryPickerView: UIPickerView!

    private var categories: [Category]!

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        categories = Category.getAllCategories()
    }

    // MARK: UIPickerViewDataSource

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    // MARK: UIPickerViewDelegate

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }

    // MARK: IBActions

    @IBAction func didClickOk(sender: AnyObject) {
        let category = categories[categoryPickerView.selectedRowInComponent(0)]

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
