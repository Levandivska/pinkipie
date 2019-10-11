//
//  FoodData.swift
//  NewVersionPinkiePie
//
//  Created by Анастасия Траверсе on 10/9/19.
//  Copyright © 2019 Veronika Romanko. All rights reserved.
//

import CoreData
import UIKit

class FoodData{
    static let shared = FoodData()
    
    func setDate()->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myStringDate = dateFormatter.string(from: Date())
        let cur_date = dateFormatter.date(from: myStringDate)
        return cur_date!
    }
    
    func addCal(_ calories:Double){
        let newdaycal = CoreDataStack.shared.newCalories()
        let today = setDate()
        newdaycal.date = today
        newdaycal.total_cal = calories
        CoreDataStack.shared.saveContext()
    }
    
    func addNut(_ carbs: Double, _ fat: Double, _ proteins: Double){
        
        let newdaynut = CoreDataStack.shared.newNutriens()
        let today = setDate()
        newdaynut.date = today
        newdaynut.carbs = carbs
        newdaynut.fat = fat
        newdaynut.proteins = proteins
        CoreDataStack.shared.saveContext()
    }
    
    func getCaloriesbyDate(_ date_var: String) ->[Double]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var calories: [Double] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DayCalories")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(fetchRequest)
            for data in result{
                calories.append(data.value(forKey: "total_cal") as! Double)
            }
        }catch {
            print("Ooopps, some error: \(error)")
        }
       return calories
    }
}
