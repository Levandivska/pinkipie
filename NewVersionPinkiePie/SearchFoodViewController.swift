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
    
    var savedFoods = [String]()

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
        let mainView = MainViewController(nibName: "MainViewController", bundle: nil)
        mainView.currentFoodName = textField.text!
        
        // TODO -> check food with API
        savedFoods.insert(mainView.currentFoodName, at: 0)
        self.performSegue(withIdentifier: "AddKcallSegue", sender: self)
        
    }
    
    func savedFoodClik(_ food: String){
        let mainView = MainViewController(nibName: "MainViewController", bundle: nil)
        mainView.currentFoodName = food
        self.performSegue(withIdentifier: "AddKcallSegue", sender: self)
    }
    
    
    func createArray() -> [String]
    {
        let food1 = "orange"
        let food2 = "apple"
        let food3 = "banana"
        
        let savedFoods: [String] = [food1, food2, food3]
        
        return savedFoods
    }
}

extension SearchFoodViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let savedFood: String
        
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
