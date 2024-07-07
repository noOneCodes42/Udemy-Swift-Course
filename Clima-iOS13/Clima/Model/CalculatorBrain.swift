//
//  CalculatorBrain.swift
//  Clima
//
//  Created by Neel Arora on 6/12/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation


struct CalculatorBrain{
    func calculator(_ temp: String) -> String{
        var degrees = Float(temp)
        var equation = (degrees! * 9/5) + 32
        var answer = String(format: "%.0f", equation)
        return answer  
    }
}
