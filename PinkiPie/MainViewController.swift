import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var ResultView: UIView!
    @IBOutlet weak var kcallleftLabel: UILabel!
    @IBOutlet weak var kcalPerDay: UILabel!
    @IBOutlet weak var kcalConsumed: UILabel!
    @IBOutlet weak var foodWeightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResultView.layer.cornerRadius = ResultView.frame.size.width/2
        ResultView.clipsToBounds = true
        ResultView.layer.borderColor = UIColor.orange.cgColor
        ResultView.layer.borderWidth = 5.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        kcallleftLabel.text = "\(((10 * (weight_ as NSString).doubleValue) + 6.25 * ((height_ as NSString).doubleValue) - (5 * (age_ as NSString).doubleValue) - 161) * 1.2)"
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        if let kcal = Int(foodWeightTextField.text!){
            kcallleftLabel.text = String(Int(kcallleftLabel.text!)! - kcal)
            kcalConsumed.text = String(Int(kcalConsumed.text!)! + kcal)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
