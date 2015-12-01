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

    var limit: Float? {
        get {
            return limitNumber?.floatValue
        }

        set(newLimit) {
            limitNumber = newLimit
        }
    }

    class func getAllCategories() -> [Category] {
        let fetchRequest = NSFetchRequest(entityName: "Category")
        return (try? AppDelegate.instance().managedObjectContext.executeFetchRequest(fetchRequest) ?? []) as! [Category]
    }

    class func newInstance(name: String, limit: Float?) -> Category {
        let category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: AppDelegate.instance().managedObjectContext) as! Category
        category.name = name
        category.limit = limit

        AppDelegate.instance().saveContext()

        return category
    }
    
}