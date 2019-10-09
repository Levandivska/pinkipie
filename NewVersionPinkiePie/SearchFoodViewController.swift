//
//  SearchFoodViewController.swift
//  NewVersionPinkiePie
//
//  Created by оля on 10/8/19.
//  Copyright © 2019 Veronika Romanko. All rights reserved.
//

import UIKit
import Foundation

class SearchFoodViewController: UIViewController {
    
    var savedFoods = [Food]()
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var ChooseFoodButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        savedFoods = createArray()
    }

    
    @IBAction func foodClik(_ sender: UIButton){
        //  find  textField.text in API and ..
        // add food to current food in main view controller
        self.performSegue(withIdentifier: "AddKcallSegue", sender: self)

    }
    
    func savedFoodClik(_ food: Food){
        //  find  textField.text in API and ..
        // add food to current food in main view controller
        self.performSegue(withIdentifier: "AddKcallSegue", sender: self)
        
    }


    func createArray() -> [Food]
    {
        let food1 = Food("porage", 100)
        let food2 = Food("apple", 50)
        let food3 = Food("banana", 200)
        
        let savedFoods: [Food] = [food1, food2, food3]
        
        // for i in food:
        // allFoods.append(Food(name, calNUm))
        return savedFoods
    }
}

extension SearchFoodViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedFoods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let savedFood: Food

        savedFood = savedFoods[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodsCell") as! FoodCell
        cell.setFood(savedFood)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        savedFoodClik(savedFoods[indexPath.row])
    }

}
