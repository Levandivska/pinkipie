//
//  DayCalories+CoreDataProperties.swift
//  NewVersionPinkiePie
//
//  Created by Анастасия Траверсе on 10/9/19.
//  Copyright © 2019 Veronika Romanko. All rights reserved.
//
//

import Foundation
import CoreData


extension DayCalories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayCalories> {
        return NSFetchRequest<DayCalories>(entityName: "DayCalories")
    }

    @NSManaged public var date: Date?
    @NSManaged public var total_cal: Double

}
