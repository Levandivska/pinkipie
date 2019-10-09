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
    
    @IBAction func finishButtonClick(_ sender: UIButton){
        //textField.text!
        self.performSegue(withIdentifier: "FinishSeuge", sender: self)
    }

    @IBAction func addMoreButtonClick(_ sender: UIButton){
        //textField.text!
        self.performSegue(withIdentifier: "AddMoreSeuge", sender: self)

    }
}


