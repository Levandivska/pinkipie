//
//  Food.swift
//  secattemp
//
//  Created by оля on 10/7/19.
//  Copyright © 2019 Olya. All rights reserved.
//

import UIKit

class Food{
    var name: String
    var kcalNum: Int
    
    init(_ name: String,_ kcalNum: Float){
        self.name = name
        self.kcalNum = Int(kcalNum)
    }
}
