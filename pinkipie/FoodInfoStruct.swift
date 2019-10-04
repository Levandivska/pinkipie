//
//  FoodInfoStruct.swift
//  pinkipie
//
//  Created by Анастасия Траверсе on 10/4/19.
//  Copyright © 2019 pinkipie. All rights reserved.
//

import Foundation

struct NutrientInfo{
    var label:  String
    var quantity: Int
    var unit: String
}

struct FoodInfo {
    var totalNutrients: [TotalNutrientsInfo]
}

struct TotalNutrientsInfo {
    var ENERC_KCAL: [NutrientInfo]
    var FAT: [NutrientInfo]
    var CHOCDF: [NutrientInfo]
    var PROCNT: [NutrientInfo]
}

extension NutrientInfo:Decodable{
    enum Keys: String, CodingKey {
        case label = "label"
        case quantity = "quantity"
        case unit = "unit"
    }
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: Keys.self)
        self.label = try container.decode(String.self, forKey: .label)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.unit = try container.decode(String.self, forKey: .unit)
    }
}


extension TotalNutrientsInfo: Decodable{
    enum Keys:String, CodingKey {
        case ENERC_KCAL = "ENERC_KCAL"
        case FAT = "FAT"
        case CHOCDF = "CHOCDF"
        case PROCNT = "PROCNT"
    }
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: Keys.self)
        self.ENERC_KCAL = try container.decode([NutrientInfo].self, forKey: .ENERC_KCAL)
        self.FAT = try container.decode([NutrientInfo].self, forKey: .FAT)
        self.CHOCDF = try container.decode([NutrientInfo].self, forKey: .CHOCDF)
        self.PROCNT = try container.decode([NutrientInfo].self, forKey: .PROCNT)
    }
}

extension FoodInfo: Decodable {
    enum Keys: String, CodingKey {
        case totalNutrients = "totalNutrients"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.totalNutrients = try container.decode([TotalNutrientsInfo].self, forKey: .totalNutrients)
    }
}
