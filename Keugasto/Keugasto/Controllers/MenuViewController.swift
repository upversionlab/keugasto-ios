//
//  MenuViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/3/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    fileprivate let menuEntries = [
        "Expenses",
        "Categories",
        "Balance"
    ]

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuEntries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu Entry", for: indexPath) as! MenuEntryTableViewCell
        cell.menuEntryLabel.text = menuEntries[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainViewController = UIApplication.shared.keyWindow?.rootViewController as? MainViewController
        mainViewController?.switchToViewControllerWithIdentifier("\(menuEntries[indexPath.row]) Screen")
        mainViewController?.didClickOnMenu()
    }

}
