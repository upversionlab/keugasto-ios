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
    @objc optional func didAddExpense(_ expense: Expense)
    @objc optional func didCancelAddExpense()
}

class AddExpenseViewController: BaseViewController, UITextFieldDelegate, CategoryPickerDelegate, DatePickerDelegate {

    var delegate: AddExpenseDelegate?

    @IBOutlet fileprivate weak var categoryTextField: UITextField!
    @IBOutlet fileprivate weak var valueTextField: UITextField!
    @IBOutlet fileprivate weak var dateTextField: UITextField!
    @IBOutlet fileprivate weak var userDescriptionTextField: UITextField!

    fileprivate var selectedCategory: Category?
    fileprivate var selectedValue: Float?
    fileprivate var selectedDate: Date?
    fileprivate var selectedDescription: String?

    // MARK: UIViewController

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Category Picker Segue" {
            let categoryPickerViewController = segue.destination as! CategoryPickerViewController
            categoryPickerViewController.delegate = self
            return
        }

        if segue.identifier == "Date Picker Segue" {
            let datePickerViewController = segue.destination as! DatePickerViewController
            datePickerViewController.delegate = self
            return
        }
    }

    // MARK: UITextFieldDelegate

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.markAsValid()

        if textField == categoryTextField {
            performSegue(withIdentifier: "Category Picker Segue", sender: nil)
            return false
        }

        if textField == dateTextField {
            performSegue(withIdentifier: "Date Picker Segue", sender: nil)
            return false
        }

        return true
    }

    // MARK: CategoryPickerDelegate

    func didPickCategory(_ category: Category?) {
        if category != nil {
            selectedCategory = category
            categoryTextField.text = selectedCategory!.name
        } else {
            categoryTextField.text = ""
        }
    }

    // MARK: DatePickerDelegate

    func didPickDate(_ date: Date) {
        selectedDate = date

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short

        dateTextField.text = dateFormatter.string(from: date)
    }

    // MARK: IBActions

    @IBAction func didClickOnAdd(_ sender: AnyObject) {
        selectedValue = nil
        if valueTextField.text != nil {
            selectedValue = Float(valueTextField.text!)
        }

        selectedDescription = userDescriptionTextField.text

        if validateInputs() {
            let expense = Expense.newInstance(selectedCategory!, value: selectedValue!, date: selectedDate!, userDescription: selectedDescription)

            dismiss(animated: true) { () -> Void in
                self.delegate?.didAddExpense?(expense)
            }
        }
    }

    @IBAction func didClickOnCancel(_ sender: AnyObject) {
        dismiss(animated: true) { () -> Void in
            self.delegate?.didCancelAddExpense?()
        }
    }

    // MARK: Private methods

    fileprivate func validateInputs() -> Bool {
        var valid = true

        if selectedCategory == nil {
            categoryTextField.markAsInvalid()
            valid = false
        }

        if selectedValue == nil {
            valueTextField.markAsInvalid()
            valid = false
        }

        if selectedDate == nil {
            dateTextField.markAsInvalid()
            valid = false
        }

        return valid
    }

}
