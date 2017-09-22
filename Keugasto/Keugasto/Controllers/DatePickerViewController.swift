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
    @objc optional func didPickDate(_ date: Date)
    @objc optional func didCancelPickDate()
}

class DatePickerViewController: BaseViewController {

    var delegate: DatePickerDelegate?

    @IBOutlet fileprivate weak var datePickerView: UIDatePicker!

    // MARK: IBActions

    @IBAction func didClickOk(_ sender: AnyObject) {
        let date = datePickerView.date

        dismiss(animated: true) { () -> Void in
            self.delegate?.didPickDate?(date)
        }
    }

    @IBAction func didClickOutside(_ sender: AnyObject) {
        dismiss(animated: true) { () -> Void in
            self.delegate?.didCancelPickDate?()
        }
    }

}
