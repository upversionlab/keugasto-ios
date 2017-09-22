//
//  MainViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/3/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet fileprivate weak var contentContainerView: UIView!
    @IBOutlet fileprivate weak var menuContainerView: UIView!
    @IBOutlet fileprivate weak var menuBackgroundView: UIView!
    @IBOutlet fileprivate weak var menuConstraint: NSLayoutConstraint!

    fileprivate var menuViewController: UIViewController!

    // MARK: UIViewController

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Constants.navigationBarColor
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Menu Segue") {
            menuViewController = segue.destination
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
            menuBackgroundView.isHidden = false
        }

        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (Bool) -> Void in
            if shouldCloseMenu {
                self.menuBackgroundView.isHidden = true
            }
        }) 
    }

    @IBAction fileprivate func didClickOutsideMenu(_ sender: AnyObject) {
        didClickOnMenu()
    }

    func switchToViewControllerWithIdentifier(_ identifier: String) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: identifier)
        if viewController != nil {
            replaceContentViewControllerBy(viewController!)
        }
    }

    fileprivate func replaceContentViewControllerBy(_ viewController: UIViewController) {
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
        viewController.didMove(toParentViewController: self)
    }

}

