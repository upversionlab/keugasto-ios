//
//  MainViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/3/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private weak var menuContainerView: UIView!
    @IBOutlet private weak var menuBackgroundView: UIView!
    @IBOutlet private weak var menuConstraint: NSLayoutConstraint!

    // MARK: Menu actions

    func didClickOnMenu() {
        view.layoutIfNeeded()

        let shouldCloseMenu = menuConstraint.constant > 0

        if shouldCloseMenu {
            menuConstraint.constant = 0
        } else {
            menuConstraint.constant = menuContainerView.frame.width
            menuBackgroundView.hidden = false
        }

        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }) { (Bool) -> Void in
            if shouldCloseMenu {
                self.menuBackgroundView.hidden = true
            }
        }
    }

    @IBAction private func didClickOutsideMenu(sender: AnyObject) {
        didClickOnMenu()
    }

}

