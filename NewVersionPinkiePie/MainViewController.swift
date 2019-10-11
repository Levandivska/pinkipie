import UIKit
import Foundation

class MainViewController: UIViewController {

    var currentFoodName: String = ""
    var currentMass: Int = 0
    
    @IBOutlet weak var ResultView: UIView!
    @IBOutlet weak var kcalleft: UILabel!
    @IBOutlet weak var kcalPerDay: UILabel!
    @IBOutlet weak var kcalConsumed: UILabel!
    @IBOutlet weak var myButton: UIButton!

    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ResultView.layer.cornerRadius = ResultView.frame.size.width/2
        ResultView.clipsToBounds = true
        ResultView.layer.borderColor = UIColor.white.cgColor
        ResultView.layer.borderWidth = 5.0
        
        NotificationCenter.default.addObserver(self, selector: #selector(storageDidSync), name: NSNotification.Name(rawValue: "synced"), object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        kcalleft.text = "\(Int(((10 * (weight_ as NSString).doubleValue) + 6.25 * ((height_ as NSString).doubleValue) - (5 * (age_ as NSString).doubleValue) - 161) * 1.2))"
        kcalPerDay.text = "\(Int(((10 * (weight_ as NSString).doubleValue) + 6.25 * ((height_ as NSString).doubleValue) - (5 * (age_ as NSString).doubleValue) - 161) * 1.2))"
        kcalConsumed.text = "0"
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SerachFoodSegue", sender: self)
    }
    
    @objc func storageDidSync() {
        print("DONE!")
        let prodInfo = FoodStorage.shared.food
        let addkcal = prodInfo?.ENERC_KCAL.quantity
        FoodData.shared.addCal(Double(addkcal!))
    }
    
    func AddKcal() {
        // find addkcal Using currentMass, currentFoodName
        //
        FoodApiRequest.shared.getFoodInfo(currentFoodName, currentMass)
        //        kcalleft.text = String(Int(kcalleft.text!)! - addkcal)
        //        kcalConsumed.text = String(Int(kcalConsumed.text!)! + addkcal)
    }
}

