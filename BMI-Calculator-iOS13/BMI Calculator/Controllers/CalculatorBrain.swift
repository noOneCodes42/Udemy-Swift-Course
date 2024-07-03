//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Neel Arora on 5/24/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    var bmiValue: BMI?

    mutating func calulateBMI(height: Float, weight: Float){
       let bmiValue1 = weight/pow(2,height)
        if bmiValue1 < 18.5{
            bmiValue = BMI(value: bmiValue1, advice: "Eat More pies!", color: .blue)
        }else if bmiValue1 > 18.5 && bmiValue1 < 24.9{
            bmiValue = BMI(value: bmiValue1, advice: "Fit as a fiddle!", color: .green)
        }else{
            bmiValue = BMI(value: bmiValue1, advice: "Eat less pies", color: .red)
        }
        //
        
    }
    func getBMIValue()-> String{
        let bmiToDecimalPlace = String(format: "%.1f", bmiValue?.value ?? 0.0)
        return bmiToDecimalPlace
    }
    func getAdvice()-> String{
        return bmiValue?.advice ?? "No Advice"
    }
    func getColor() -> UIColor{
        return bmiValue?.color ?? .white
    }
}
