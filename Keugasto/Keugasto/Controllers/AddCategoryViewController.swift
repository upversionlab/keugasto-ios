//
//  AddCategoryViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/17/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

@objc
protocol AddCategoryDelegate {
    optional func didAddCategory(category: Category)
    optional func didCancelAddCategory()
}

class AddCategoryViewController: BaseViewController, UITextFieldDelegate {

    var delegate: AddCategoryDelegate?

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var limitTextField: UITextField!

    private var selectedName: String?
    private var selectedLimit: Float?

    // MARK: UITextFieldDelegate

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        textField.markAsValid()
        return true
    }

    // MARK: IBActions

    @IBAction func didClickOnAdd(sender: AnyObject) {
        selectedName = nil
        if nameTextField.text != nil {
            selectedName = nameTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }

        selectedLimit = nil
        if limitTextField.text != nil {
            selectedLimit = Float(limitTextField.text!)
        }

        if validateInputs() {
            let category = Category.newInstance(selectedName!, limit: selectedLimit)

            dismissViewControllerAnimated(true) { () -> Void in
                self.delegate?.didAddCategory?(category)
            }
        }
    }

    @IBAction func didCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didCancelAddCategory?()
        }
    }

    // MARK: Private methods

    private func validateInputs() -> Bool {
        var valid = true

        if selectedName == nil || selectedName!.characters.count == 0 {
            nameTextField.markAsInvalid()
            valid = false
        }
        
        return valid
    }

}

