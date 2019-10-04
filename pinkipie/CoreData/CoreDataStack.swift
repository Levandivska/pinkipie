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
        let container = NSPersistentContainer(name: "pinky_example")
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
    func newdaycalories() -> DayTotalCalories {
        let newcalories = NSEntityDescription.insertNewObject(
            forEntityName: "DayTotalCalories",
            into: persistentContainer.viewContext
        ) as! DayTotalCalories
        
        return newcalories
    }
//    calories.DayTotalCalories?.calories
    
    func newfoodsearch()-> FoodSearch{
        let newsearch = NSEntityDescription.insertNewObject(forEntityName: "FoodSearch", into: persistentContainer.viewContext) as! FoodSearch
        return newsearch
    }
    
    func newNutriens()->DayTotalNutriens{
        let newNut = NSEntityDescription.insertNewObject(forEntityName: "DayTotalNutriens", into: persistentContainer.viewContext) as! DayTotalNutriens
        return newNut
    }
    
    func remove(search: FoodSearch) {
        persistentContainer.viewContext.delete(search)
    }

    func remove(totalcalories: DayTotalCalories) {
        persistentContainer.viewContext.delete(totalcalories)
    }

    func remove(nutriens: DayTotalNutriens) {
        persistentContainer.viewContext.delete(nutriens)
    }
    
    
}

