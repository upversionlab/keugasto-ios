//
//  Expense.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/3/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import Foundation
import CoreData

@objc(Expense)
class Expense: NSManagedObject {

    @NSManaged var category: Category!
    @NSManaged var valueNumber: NSNumber!
    @NSManaged var date: NSDate!
    @NSManaged var userDescription: String?

    var value: Float! {
        get {
            return valueNumber.floatValue
        }

        set(newValue) {
            valueNumber = newValue
        }
    }

    class func getAllExpenses() -> [Expense] {
        let fetchRequest = NSFetchRequest(entityName: "Expense")
        return (try? AppDelegate.instance().managedObjectContext.executeFetchRequest(fetchRequest) ?? []) as! [Expense]
    }

    class func newInstance(category: Category, value: Float, date: NSDate, userDescription: String?) -> Expense {
        let expense = NSEntityDescription.insertNewObjectForEntityForName("Expense", inManagedObjectContext: AppDelegate.instance().managedObjectContext) as! Expense
        expense.category = category
        expense.value = value
        expense.date = date
        expense.userDescription = userDescription

        AppDelegate.instance().saveContext()

        return expense
    }

}