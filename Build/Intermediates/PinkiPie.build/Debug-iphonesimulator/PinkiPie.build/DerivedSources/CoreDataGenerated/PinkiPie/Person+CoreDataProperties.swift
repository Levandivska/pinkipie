//
//  Person+CoreDataProperties.swift
//  
//
//  Created by Veronika Romanko on 10/4/19.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var height: Double
    @NSManaged public var name: String?
    @NSManaged public var weight: Double

}
