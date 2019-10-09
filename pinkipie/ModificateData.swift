//
//  ModificateData.swift
//  pinkipie
//
//  Created by Анастасия Траверсе on 10/9/19.
//  Copyright © 2019 pinkipie. All rights reserved.
//

import Foundation

class ModificateData{
    static let shared = ModificateData()
    func addDate()->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myStringDate = dateFormatter.string(from: Date())
        let cur_date = dateFormatter.date(from: myStringDate)
        return cur_date!
    }
    func addDayCal(_ calories:Int16){
        let newdaycal = CoreDataStack.shared.newdaycalories()
        let cur_date = addDate()
        newdaycal.date = cur_date
        newdaycal.total_cal = calories
    }
    func addDayNut(_ carbs: Double, _ fat: Double, _ proteins: Double){
        let newdaynut = CoreDataStack.shared.newNutriens()
//        let cur_date = addDate()
        newdaynut.carbs = carbs
        newdaynut.fat = fat
        newdaynut.proteins = proteins
    }
    func addSearch(_ lastsearch: String){
        let newsearch = CoreDataStack.shared.newfoodsearch()
        newsearch.foodname = lastsearch
    }
}
