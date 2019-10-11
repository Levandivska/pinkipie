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

    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var addMoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let mainView = MainViewController(nibName: "MainViewController", bundle: nil)
        
        if let curm = Int(textField.text!){
            mainView.currentMass = curm
            mainView.AddKcal()
//            self.navigationController?.pop
            self.performSegue(withIdentifier: "FinishSeuge", sender: self)
        }
        else{
            alertMessage("Error", "Incorrect data, Enter the number of grams.")
            print("fail data")
        }
        
    }

    @IBAction func addMoreButtonClick(_ sender: UIButton){
        //textField.text!
        let mainView = MainViewController(nibName: "MainViewController", bundle: nil)
        
        if let curm = Int(textField.text!){
            mainView.currentMass = curm
            mainView.AddKcal()
            
            self.performSegue(withIdentifier: "AddMoreSeuge", sender: self)
//            self.navigationController?.pop
        }
        else{
            alertMessage("Error", "Incorrect data, Enter the number of grams.")
            print("fail data")
        }
    }
}


