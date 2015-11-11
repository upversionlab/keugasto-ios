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

class AddExpenseViewController: UIViewController {

    var delegate: AddExpenseDelegate?

    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var valueTextField: UITextField!

    @IBAction func didAddExpense(sender: AnyObject) {
        let expense = Expense()
        expense.name = descriptionTextField.text!
        expense.value = Float(valueTextField.text!)

        dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didAddExpense?(expense)
        }
    }

    @IBAction func didCancelAddExpense(sender: AnyObject) {
        dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didCancelAddExpense?()
        }
    }
}
