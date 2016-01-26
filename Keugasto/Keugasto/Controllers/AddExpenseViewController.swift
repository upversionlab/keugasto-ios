//
//  AddExpenseViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/10/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

@objc
protocol AddExpenseDelegate {
    optional func didAddExpense(expense: Expense)
    optional func didCancelAddExpense()
}

class AddExpenseViewController: BaseViewController, UITextFieldDelegate, CategoryPickerDelegate, DatePickerDelegate {

    var delegate: AddExpenseDelegate?

    @IBOutlet private weak var categoryTextField: UITextField!
    @IBOutlet private weak var valueTextField: UITextField!
    @IBOutlet private weak var dateTextField: UITextField!
    @IBOutlet private weak var userDescriptionTextField: UITextField!

    private var selectedCategory: Category!
    private var selectedDate: NSDate!

    // MARK: UIViewController

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Category Picker Segue" {
            let categoryPickerViewController = segue.destinationViewController as! CategoryPickerViewController
            categoryPickerViewController.delegate = self
            return
        }

        if segue.identifier == "Date Picker Segue" {
            let datePickerViewController = segue.destinationViewController as! DatePickerViewController
            datePickerViewController.delegate = self
            return
        }
    }

    // MARK: UITextFieldDelegate

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == categoryTextField {
            performSegueWithIdentifier("Category Picker Segue", sender: nil)
            return false
        }

        if textField == dateTextField {
            performSegueWithIdentifier("Date Picker Segue", sender: nil)
            return false
        }

        return true
    }

    // MARK: CategoryPickerDelegate

    func didPickCategory(category: Category?) {
        if category != nil {
            selectedCategory = category
            categoryTextField.text = selectedCategory.name
        } else {
            categoryTextField.text = ""
        }
    }

    // MARK: DatePickerDelegate

    func didPickDate(date: NSDate) {
        selectedDate = date

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle

        dateTextField.text = dateFormatter.stringFromDate(date)
    }

    // MARK: IBActions

    @IBAction func didClickOnAdd(sender: AnyObject) {
        let value = Float(valueTextField.text!)!
        let userDescription = userDescriptionTextField.text

        let expense = Expense.newInstance(selectedCategory, value: value, date: selectedDate, userDescription: userDescription)

        dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didAddExpense?(expense)
        }
    }

    @IBAction func didClickOnCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didCancelAddExpense?()
        }
    }
}
