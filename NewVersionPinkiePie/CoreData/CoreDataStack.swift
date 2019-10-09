//
//  CoreDataStack.swift
//  pinkipie
//
//  Created by Анастасия Траверсе on 10/4/19.
//  Copyright © 2019 pinkipie. All rights reserved.
//

import CoreData

class CoreDataStack{
    static let shared = CoreDataStack()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "pink")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func newCalories() -> DayCalories{
        let newcalories = NSEntityDescription.insertNewObject(
            forEntityName: "DayCalories",
            into: persistentContainer.viewContext
        ) as! DayCalories
        return newcalories
    }
    func newNutriens() -> DayNutriens{
        let newNut = NSEntityDescription.insertNewObject(
            forEntityName: "DayNutriens",
            into: persistentContainer.viewContext
        ) as! DayNutriens
        return newNut
    }
    func remove(totalcalories: DayCalories) {
        persistentContainer.viewContext.delete(totalcalories)
    }

    func remove(nutriens: DayNutriens) {
        persistentContainer.viewContext.delete(nutriens)
    }
}

