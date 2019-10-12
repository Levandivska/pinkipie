//
//  FoodStorage.swift
//  pinkipie
//
//  Created by Анастасия Траверсе on 10/4/19.
//  Copyright © 2019 pinkipie. All rights reserved.
//
import Foundation

class FoodStorage {
    static let shared = FoodStorage ()
    
    var food: TotalNutrientsInfo! 
    
    func sync() {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "synced")))
    }
}
