//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Neel Arora on 5/26/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    var result: Double?
    var numberOfPeople1: Int?
    var tipPercentage: String?
    @IBOutlet weak var resultAmount: UILabel!
    @IBOutlet weak var numberOfPeople: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultAmount.text = String(format:"%.2f",result!)
        numberOfPeople.text = "Split between \(numberOfPeople1!) people, with \(tipPercentage!) tip"
        // Do any additional setup after loading the view.
    }
    @IBAction func recalculate(_ sender: UIButton) {
        self.dismiss(animated: true)
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
