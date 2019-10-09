import UIKit
import Foundation

class MainViewController: UIViewController {

    var currentFoodName: String = ""
    var currentMass: Float = 0.0
    
    var foods: [Food] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ResultView: UIView!
    @IBOutlet weak var kcalleft: UILabel!
    @IBOutlet weak var kcalPerDay: UILabel!
    @IBOutlet weak var kcalConsumed: UILabel!
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var myButton: UIButton!

    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredFoods = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ResultView.layer.cornerRadius = ResultView.frame.size.width/2
        ResultView.clipsToBounds = true
        ResultView.layer.borderColor = UIColor.white.cgColor
        ResultView.layer.borderWidth = 5.0
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Food"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.tableHeaderView = searchController.searchBar
        tableView.delegate = self
        tableView.dataSource = self
        
        foods = createArray()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredFoods = foods.filter({( food : Food) -> Bool in
            return food.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func foodClick(_ food: Food) {
        if let kcal = Float(mainTextField.text!){
            kcalleft.text = String(Float(kcalleft.text!)! - kcal)
            kcalConsumed.text = String(Float(kcalConsumed.text!)! + kcal)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        kcalleft.text = "\(((10 * (weight_ as NSString).doubleValue) + 6.25 * ((height_ as NSString).doubleValue) - (5 * (age_ as NSString).doubleValue) - 161) * 1.2)"
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        if let kcal = Float(mainTextField.text!){
            kcalleft.text = String(Float(kcalleft.text!)! - kcal)
            kcalConsumed.text = String(Float(kcalConsumed.text!)! + kcal)
        }
        self.performSegue(withIdentifier: "SerachFoodSegue", sender: self)
    }
    
    func createArray() -> [Food]
    {
        let food1 = Food("porage", 100)
        let food2 = Food("apple", 50)
        let food3 = Food("banana", 200)
        
        let allFoods: [Food] = [food1, food2, food3]
        // for i in food:
        // allFoods.append(Food(name, calNUm))
        return allFoods
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredFoods.count
        }
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food: Food
        if isFiltering() {
            food = filteredFoods[indexPath.row]
        } else {
            food = foods[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodCell
        cell.setFood(food)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        foodClick(foods[indexPath.row])
    }
    
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
