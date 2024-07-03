//
//  MiddleArea.swift
//  ByteCoin
//
//  Created by Neel Arora on 6/14/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct MiddleArea: Codable{
    var rate: Double
    var stringRate:String{
        return String(format: "%.2f", rate)
        
    }
}
