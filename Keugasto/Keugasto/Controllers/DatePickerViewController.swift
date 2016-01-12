//
//  DatePickerViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 12/1/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

@objc
protocol DatePickerDelegate {
    optional func didPickDate(date: NSDate)
    optional func didCancelPickDate()
}

class DatePickerViewController: BaseViewController {

    var delegate: DatePickerDelegate?

    @IBOutlet private weak var datePickerView: UIDatePicker!

    // MARK: IBActions

    @IBAction func didClickOk(sender: AnyObject) {
        let date = datePickerView.date

        dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didPickDate?(date)
        }
    }

    @IBAction func didClickOutside(sender: AnyObject) {
        dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didCancelPickDate?()
        }
    }

}
