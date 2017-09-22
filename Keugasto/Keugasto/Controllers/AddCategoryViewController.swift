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
    @objc optional func didAddCategory(_ category: Category)
    @objc optional func didCancelAddCategory()
}

class AddCategoryViewController: BaseViewController, UITextFieldDelegate {

    var delegate: AddCategoryDelegate?

    @IBOutlet fileprivate weak var nameTextField: UITextField!
    @IBOutlet fileprivate weak var limitTextField: UITextField!

    fileprivate var selectedName: String?
    fileprivate var selectedLimit: Float?

    // MARK: UITextFieldDelegate

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.markAsValid()
        return true
    }

    // MARK: IBActions

    @IBAction func didClickOnAdd(_ sender: AnyObject) {
        selectedName = nil
        if nameTextField.text != nil {
            selectedName = nameTextField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }

        selectedLimit = nil
        if limitTextField.text != nil {
            selectedLimit = Float(limitTextField.text!)
        }

        if validateInputs() {
            let category = Category.newInstance(selectedName!, limit: selectedLimit)

            dismiss(animated: true) { () -> Void in
                self.delegate?.didAddCategory?(category)
            }
        }
    }

    @IBAction func didCancel(_ sender: AnyObject) {
        dismiss(animated: true) { () -> Void in
            self.delegate?.didCancelAddCategory?()
        }
    }

    // MARK: Private methods

    fileprivate func validateInputs() -> Bool {
        var valid = true

        if selectedName == nil || selectedName!.characters.count == 0 {
            nameTextField.markAsInvalid()
            valid = false
        }
        
        return valid
    }

}

