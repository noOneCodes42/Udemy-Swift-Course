//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewContoller: UIViewController {
    var stepperValue: Double = 2
    var billText: String? = "No Text"
    var buttonClicked: Double = 0
    var result: Double = 0
    var tipPercenatge: String = "No Tip"
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        billText = billTextField.text
        if sender.currentTitle == zeroPctButton.currentTitle{
            buttonClicked = 0
            tipPercenatge = zeroPctButton.currentTitle!
            zeroPctButton.isSelected = true
            twentyPctButton.isSelected = false
            tenPctButton.isSelected = false
        }else if sender.currentTitle == tenPctButton.currentTitle{
            tipPercenatge = tenPctButton.currentTitle!
            buttonClicked = 10
            tenPctButton.isSelected = true
            zeroPctButton.isSelected = false
            twentyPctButton.isSelected = false
        }else{
            buttonClicked = 20
            tipPercenatge = twentyPctButton.currentTitle!
            twentyPctButton.isSelected = true
            tenPctButton.isSelected = false
            zeroPctButton.isSelected = false
        }
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        stepperValue = sender.value
        splitNumberLabel.text = String(format: "%.0f", stepperValue)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let g = Double(billText!)
        let decimalButtonClicked: Double = buttonClicked/100
        let add = g!*decimalButtonClicked
        result = ((g!+add)/stepperValue)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destination = segue.destination as! ResultsViewController
            let intStepper = Int(stepperValue)
            destination.result = result
            destination.numberOfPeople1 = intStepper
            destination.tipPercentage = tipPercenatge
            
        }
    }

}

