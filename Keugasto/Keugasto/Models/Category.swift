//
//  Category.swift
//  Keugasto
//
//  Created by Vinícius Uzêda on 11/17/15.
//  Copyright © 2015 Upversion Lab. All rights reserved.
//

import Foundation
import CoreData

@objc(Category)
class Category: NSManagedObject {

    @NSManaged var name: String!
    @NSManaged var limitNumber: NSNumber?
    @NSManaged var expensesSet: NSSet

    var limit: Float? {
        get {
            return limitNumber?.floatValue
        }

        set(newLimit) {
            limitNumber = newLimit! as NSNumber
        }
    }

    var expenses: [Expense] {
        get {
            return expensesSet.allObjects as! [Expense]
        }
    }

    class func getAllCategories() -> [Category] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        return (try? AppDelegate.instance().managedObjectContext.fetch(fetchRequest) as! [Category]) ?? []
    }

    class func newInstance(_ name: String, limit: Float?) -> Category {
        let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: AppDelegate.instance().managedObjectContext) as! Category
        category.name = name
        category.limit = limit

        AppDelegate.instance().saveContext()

        return category
    }
    
}
