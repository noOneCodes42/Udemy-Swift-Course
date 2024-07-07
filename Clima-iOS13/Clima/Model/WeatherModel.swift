//
//  WeatherModel.swift
//  Clima
//
//  Created by Neel Arora on 6/11/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let conditionId: Int
    let cityName: String
    let tempeture: Double
    
    var tempetureString: String{
        return String(format: "%.1f", tempeture)
    }
    
    var conditionName: String {
        switch conditionId{
        case 800:
            return "sun.min"
        case 200...232:
            return "cloud.bold"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 801...805:
            return "cloud"
        default:
            return "0"
        }
    }
}
