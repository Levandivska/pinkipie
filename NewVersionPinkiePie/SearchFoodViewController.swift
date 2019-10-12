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
    
    let dafaults = UserDefaults.standard
 
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var ChooseFoodButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "PinkiePie search food", style: .plain, target: nil, action: nil)
        tableView.delegate = self
        tableView.dataSource = self
        savedFoods = createArray()
        
        
    }
     let vc = CalculateKcalViewController()
    
    
    
    @IBAction func foodClik(_ sender: UIButton){
        let a = self.navigationController?.viewControllers[0] as! MainViewController
        a.foodName = textField.text!
        savedFoods.insert(textField.text!, at: 0)
        dafaults.set(savedFoods, forKey: "FoodArray")
        self.tableView.reloadData()
    }
    
    func savedFoodClik(_ food: String){
        let a = self.navigationController?.viewControllers[0] as! MainViewController
        a.foodName = food
    }

    func createArray() -> [String]
    {
        //var savedFoods: [String] = []
        let savedFoods = dafaults.stringArray(forKey: "FoodArray") ?? [String]()
        return savedFoods
    }
}

extension SearchFoodViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let savedFood: String
        print("You have just added \(savedFoods[indexPath.row])")
        let savedFood = savedFoods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodsCell") as! FoodCell
        cell.setFood(savedFood)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        savedFoodClik(savedFoods[indexPath.row])
    }
    
}
