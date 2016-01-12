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

class AddCategoryViewController: BaseViewController {

    var delegate: AddCategoryDelegate?

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var limitTextField: UITextField!

    // MARK: IBActions

    @IBAction func didClickOnAdd(sender: AnyObject) {
        var limit: Float? = nil
        if limitTextField.text != nil {
            limit = Float(limitTextField.text!)
        }

        let category = Category.newInstance(nameTextField.text!, limit: limit)

        dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didAddCategory?(category)
        }
    }

    @IBAction func didCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didCancelAddCategory?()
        }
    }

}

