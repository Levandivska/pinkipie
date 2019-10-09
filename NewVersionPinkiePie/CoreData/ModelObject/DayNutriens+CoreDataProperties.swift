//
//  DayNutriens+CoreDataProperties.swift
//  NewVersionPinkiePie
//
//  Created by Анастасия Траверсе on 10/9/19.
//  Copyright © 2019 Veronika Romanko. All rights reserved.
//
//

import Foundation
import CoreData


extension DayNutriens {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayNutriens> {
        return NSFetchRequest<DayNutriens>(entityName: "DayNutriens")
    }

    @NSManaged public var date: Date?
    @NSManaged public var carbs: Double
    @NSManaged public var fat: Double
    @NSManaged public var proteins: Double

}
