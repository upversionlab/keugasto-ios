//
//  MenuViewController.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/3/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource {

    private let menuEntries = [
        "Add category",
        "Balance"
    ]

    // MARK: UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuEntries.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Menu Entry", forIndexPath: indexPath) as! MenuEntryTableViewCell
        cell.menuEntryLabel.text = menuEntries[indexPath.row]
        return cell
    }

}
