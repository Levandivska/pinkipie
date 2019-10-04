//
//  DayTotalCalories+CoreDataProperties.swift
//  pinkipie
//
//  Created by Анастасия Траверсе on 10/4/19.
//  Copyright © 2019 pinkipie. All rights reserved.
//
//

import Foundation
import CoreData


extension DayTotalCalories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayTotalCalories> {
        return NSFetchRequest<DayTotalCalories>(entityName: "DayTotalCalories")
    }

    @NSManaged public var date: Date?
    @NSManaged public var total_cal: Int16

}
