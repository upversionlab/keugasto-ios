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
    @NSManaged var date: Date!
    @NSManaged var userDescription: String?

    var value: Float! {
        get {
            return valueNumber.floatValue
        }

        set(newValue) {
            valueNumber = newValue! as NSNumber
        }
    }

    class func getAllExpenses() -> [Expense] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        return (try? AppDelegate.instance().managedObjectContext.fetch(fetchRequest) as! [Expense]) ?? []
    }

    class func newInstance(_ category: Category, value: Float, date: Date, userDescription: String?) -> Expense {
        let expense = NSEntityDescription.insertNewObject(forEntityName: "Expense", into: AppDelegate.instance().managedObjectContext) as! Expense
        expense.category = category
        expense.value = value
        expense.date = date
        expense.userDescription = userDescription

        AppDelegate.instance().saveContext()

        return expense
    }

}
