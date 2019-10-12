//
//  CalculateKcalViewController.swift
//  NewVersionPinkiePie
//
//  Created by оля on 10/8/19.
//  Copyright © 2019 Veronika Romanko. All rights reserved.
//

import Foundation
import UIKit


class CalculateKcalViewController: UIViewController {
    
    var calculateMass: Int = 0
    
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var addMoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(storageDidSync), name: NSNotification.Name(rawValue: "synced"), object: nil)
        
    }
    @objc func storageDidSync() {
        print("almost done")
        let a = self.navigationController?.viewControllers[0] as! MainViewController
        let prodInfo = FoodStorage.shared.food
        a.addKcal = (prodInfo?.ENERC_KCAL.quantity)!
        a.AddKcal()
    }
    
    func alertMessage(_ title:String, _ message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //CREATING ON BUTTON
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print ("Ok")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func finishButtonClick(_ sender: UIButton){
        if let curm = Int(textField.text!){
            let a = self.navigationController?.viewControllers[0] as! MainViewController
            a.mass = curm
            // Сalculate addedkcal usinf API
            FoodApiRequest.shared.getFoodInfo(a.foodName, curm)
            self.navigationController?.popToRootViewController(animated: true)
        }
        else{
            alertMessage("Error", "Incorrect data, Enter the number of grams.")
            print("fail data")
            
        }
        
    }

    @IBAction func addMoreButtonClick(_ sender: UIButton){
        if let curm = Int(textField.text!){
            calculateMass += curm
            let a = self.navigationController?.viewControllers[0] as! MainViewController
            a.mass = calculateMass
            self.navigationController?.popViewController(animated: true)
        }
        else{
            alertMessage("Error", "Incorrect data, Enter the number of grams.")
            print("fail data")
        }
    }
}
