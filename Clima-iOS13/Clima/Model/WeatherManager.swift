//
//  WeatherManager.swift
//  Clima
//
//  Created by Neel Arora on 6/10/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather:WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=61093c9b4c0652446d34b84d1de270df&units=metric"
    var delegate:  WeatherManagerDelegate?
    mutating func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString)
    }
    func fetchWeather(longitute lon: CLLocationDegrees, latitude lat: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString)
    }
    func performRequest(_ urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with:url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let wearher = self.parsJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: wearher)
                    }
                }
            }
            task.resume()
        }
    }
    func parsJSON(_ weatherData: Data)-> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name

            
            let weather = WeatherModel(conditionId: id, cityName: name, tempeture: temp)
            return weather
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }

}
