//
//  FoodCell.swift
//  secattemp
//
//  Created by оля on 10/7/19.
//  Copyright © 2019 Olya. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell{
    
    @IBOutlet weak var foodName: UILabel!
    
    func setFood(_ food: String){
        foodName.text = food
    }
}

