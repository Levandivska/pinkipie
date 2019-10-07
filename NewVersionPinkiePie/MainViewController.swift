import UIKit

class Food{
    var name: String
    var kcalNum: Int
    
    init(_ name: String,_ kcalNum: Int){
        self.name = name
        self.kcalNum = kcalNum
    }
}

class MainViewController: UIViewController {
    
    var foods: [Food] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ResultView: UIView!
    @IBOutlet weak var kcalleft: UILabel!
    @IBOutlet weak var kcalPerDay: UILabel!
    @IBOutlet weak var kcalConsumed: UILabel!
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResultView.layer.cornerRadius = ResultView.frame.size.width/2
        ResultView.clipsToBounds = true
        ResultView.layer.borderColor = UIColor.white.cgColor
        ResultView.layer.borderWidth = 5.0
        
        tableView.delegate = self
        tableView.dataSource = self
        
        foods = createArray()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        kcalleft.text = "\(((10 * (weight_ as NSString).doubleValue) + 6.25 * ((height_ as NSString).doubleValue) - (5 * (age_ as NSString).doubleValue) - 161) * 1.2)"
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        if let kcal = Int(mainTextField.text!){
            kcalleft.text = String(Int(kcalleft.text!)! - kcal)
            kcalConsumed.text = String(Int(kcalConsumed.text!)! + kcal)
        }
    }
    
    func createArray() -> [Food]
    {
        let food1 = Food("porage", 100)
        let food2 = Food("apple", 50)
        let food3 = Food("banana", 200)
        
        let allFoods: [Food] = [food1, food2, food3]
        // for i in number food:
        // add Food(name, calNUm)
        return allFoods
    }
    
}

class FoodCell: UITableViewCell {
    
    @IBOutlet weak var foodName: UILabel!
    func setFood(_ food: Food){
        foodName.text = food.name
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = foods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodCell
        cell.setFood(food)
        return cell
    }
    
    
}
