//
//  DayTotalNutriens+CoreDataProperties.swift
//  pinkipie
//
//  Created by Анастасия Траверсе on 10/4/19.
//  Copyright © 2019 pinkipie. All rights reserved.
//
//

import Foundation
import CoreData


extension DayTotalNutriens {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayTotalNutriens> {
        return NSFetchRequest<DayTotalNutriens>(entityName: "DayTotalNutriens")
    }

    @NSManaged public var proteins: Double
    @NSManaged public var fat: Double
    @NSManaged public var carbs: Double

}
