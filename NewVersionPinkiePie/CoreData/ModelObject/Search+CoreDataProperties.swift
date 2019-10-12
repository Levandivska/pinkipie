//
//  Search+CoreDataProperties.swift
//  NewVersionPinkiePie
//
//  Created by Анастасия Траверсе on 10/12/19.
//  Copyright © 2019 Veronika Romanko. All rights reserved.
//
//

import Foundation
import CoreData


extension Search {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Search> {
        return NSFetchRequest<Search>(entityName: "Search")
    }

    @NSManaged public var name: String?

}
