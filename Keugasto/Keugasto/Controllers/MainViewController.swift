//
//  MainViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/3/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var menuContainerView: UIView!
    @IBOutlet private weak var menuBackgroundView: UIView!
    @IBOutlet private weak var menuConstraint: NSLayoutConstraint!

    private var menuViewController: UIViewController!

    // MARK: UIViewController

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Constants.navigationBarColor
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Menu Segue") {
            menuViewController = segue.destinationViewController
        }
    }

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

    func switchToViewControllerWithIdentifier(identifier: String) {
        let viewController = storyboard?.instantiateViewControllerWithIdentifier(identifier)
        if viewController != nil {
            replaceContentViewControllerBy(viewController!)
        }
    }

    private func replaceContentViewControllerBy(viewController: UIViewController) {
        // Remove all child view controllers that are not the menu view controller
        for viewController in childViewControllers {
            if viewController != menuViewController {
                viewController.removeFromParentViewController()
            }
        }

        // Clear content view
        for view in contentContainerView.subviews {
            view.removeFromSuperview()
        }

        // Add the specified view controller as a child view controller
        addChildViewController(viewController)

        // Add the view controller's view in the content container view
        contentContainerView.addSubview(viewController.view)

        // Notifying the view controller of these movements
        viewController.didMoveToParentViewController(self)
    }

}

