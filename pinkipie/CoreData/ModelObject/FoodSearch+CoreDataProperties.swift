//
//  FoodSearch+CoreDataProperties.swift
//  pinkipie
//
//  Created by Анастасия Траверсе on 10/4/19.
//  Copyright © 2019 pinkipie. All rights reserved.
//
//

import Foundation
import CoreData


extension FoodSearch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodSearch> {
        return NSFetchRequest<FoodSearch>(entityName: "FoodSearch")
    }

    @NSManaged public var foodname: String?

}
