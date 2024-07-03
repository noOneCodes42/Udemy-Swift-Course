//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Neel Arora on 5/24/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var bmiResultLabel: UILabel!
    override func viewDidLoad() {
        bmiResultLabel.text = bmiValue
        adviceLabel.text = advice
        view.backgroundColor = color
        super.viewDidLoad()
        
        
    }
    @IBAction func recalculatePressed(_ sender: UIButton) {
        // This is dismissing itself
        self.dismiss(animated: true)
    }

}
