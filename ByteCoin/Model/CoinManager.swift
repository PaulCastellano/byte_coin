//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func onSuccessUpdate(coinModel: CoinModel)
    func onFailedUpdate(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "API-KEY"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func fetchData(by id: Int) {
        let urlString = "\(baseURL)/\(currencyArray[id])?apikey=\(apiKey)"
        performeString(with: urlString)
    }
    
    func performeString(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.onFailedUpdate(error: error)
                return
            }
            if let safeData = data {
                if let coinModel = self.parseJSON(safeData) {
                    self.delegate?.onSuccessUpdate(coinModel: coinModel)
                }
            }
        }
        
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(Rate.self, from: data)
            
            let quote   : String = decodeData.asset_id_quote
            let rate    : String = String(format: "%.2f", decodeData.rate)
            
            let coinModel = CoinModel(quote: quote, rate: rate)
            
            return coinModel
        } catch {
            delegate?.onFailedUpdate(error: error)
            return nil
        }
    }
}
