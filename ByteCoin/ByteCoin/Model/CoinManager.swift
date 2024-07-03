//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate{
    func didFailWithError(error: Error)
    func updateUI(coin: MiddleArea, coinManager12: CoinManager)
}
struct CoinManager {
    var x = ""
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "8DB5ECEC-7B46-4BCE-8334-E9E839692D6F"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var delegate: CoinManagerDelegate?
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        performTask(urlString)
    }
    func performTask(_ urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            task.resume()
        }
        
    }
     func handle(data: Data?, response: URLResponse?, error: Error?){
        if error != nil{
            delegate?.didFailWithError(error: error!)
            return
        }
        
        if let safeData = data{
            let dataString = String(data: safeData, encoding: .utf8)
            if let currency12 = self.parseJSON(safeData){
                self.delegate?.updateUI(coin: currency12, coinManager12: self)
            }

        }
    }
    func parseJSON(_ data: Data)->MiddleArea?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(MiddleArea.self , from: data)
            let rate = decodedData.rate
            
            let finalAnswer = MiddleArea(rate: rate)
            return finalAnswer
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
