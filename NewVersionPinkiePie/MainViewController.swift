import UIKit
import Foundation

class MainViewController: UIViewController{
    
    var foodName: String = ""
    var mass: Int = 0
    var addKcal: Int = 0
    
    @IBOutlet weak var ResultView: UIView!
    @IBOutlet weak var kcalleft: UILabel!
    @IBOutlet weak var kcalPerDay: UILabel!
    @IBOutlet weak var kcalConsumed: UILabel!
    @IBOutlet weak var myButton: UIButton!

    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "PinkiePie kcal tracker", style: .plain, target: nil, action: nil)
        
        ResultView.layer.cornerRadius = ResultView.frame.size.width/2
        ResultView.clipsToBounds = true
        ResultView.layer.borderColor = UIColor.white.cgColor
        ResultView.layer.borderWidth = 5.0
        
        kcalleft.text = "\(Int(((10 * (weight_ as NSString).doubleValue) + 6.25 * ((height_ as NSString).doubleValue) - (5 * (age_ as NSString).doubleValue) - 161) * 1.2))"
        kcalPerDay.text = "\(Int(((10 * (weight_ as NSString).doubleValue) + 6.25 * ((height_ as NSString).doubleValue) - (5 * (age_ as NSString).doubleValue) - 161) * 1.2))"
        kcalConsumed.text = "0"
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        kcalleft.text = "\(Int(((10 * (weight_ as NSString).doubleValue) + 6.25 * ((height_ as NSString).doubleValue) - (5 * (age_ as NSString).doubleValue) - 161) * 1.2))"
//        kcalPerDay.text = "\(Int(((10 * (weight_ as NSString).doubleValue) + 6.25 * ((height_ as NSString).doubleValue) - (5 * (age_ as NSString).doubleValue) - 161) * 1.2))"
//        kcalConsumed.text = "0"
        
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
    }
    
    func AddKcal() {
        kcalleft.text = String(Int(kcalleft.text!)! - self.addKcal)
        kcalConsumed.text = String(Int(kcalConsumed.text!)! + self.addKcal)
    }
}

