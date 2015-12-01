//
//  BalanceViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/17/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {

    // MARK: IBActions

    @IBAction func didClickOnMenu(sender: AnyObject) {
        let mainViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? MainViewController
        mainViewController?.didClickOnMenu()
    }

}
