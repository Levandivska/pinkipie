//
//  Person+CoreDataProperties.swift
//  NewVersionPinkiePie
//
//  Created by Анастасия Траверсе on 10/9/19.
//  Copyright © 2019 Veronika Romanko. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: Double
    @NSManaged public var height: Double
    @NSManaged public var name: String?
    @NSManaged public var weight: Double

}
