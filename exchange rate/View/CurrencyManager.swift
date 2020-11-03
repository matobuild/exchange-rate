//
//  CurrencyManager.swift
//  exchange rate
//
//  Created by kittawat phuangsombat on 2020/10/19.
//

import Foundation

protocol CurrencyManagerDelegate {
    func didUpdateCurrency(_ currencyManager: CurrencyManager, currency : CurrencyModel)
    func didFailWithError(error: Error)
}

struct CurrencyManager {
    let currencyURL = K.URLForApi
    
    var delegate : CurrencyManagerDelegate?
    
    func fetchCurrency(currency : String) {
        let urlString = "\(currencyURL)\(currency)"
        performRequest(with : urlString)
    }
    
    func performRequest(with urlString : String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    
                            if let currency = self.parseJSON(safeData){
                                self.delegate?.didUpdateCurrency(self, currency: currency)
                   
                    }
                }
            }
            task.resume()
        }
        
    }
    func parseJSON(_ currencydata : Data) -> CurrencyModel? {
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(CurrencyData.self, from: currencydata)
            
            
            let baseCurrency = decodeData.base_code
            let thbCurrency = decodeData.conversion_rates.THB
            
            let currency = CurrencyModel(baseCurrency: baseCurrency, convertCurrency: thbCurrency)
            print(currency.baseCurrency)
            print(currency.convertCurrency)
            
            return currency
        }catch{
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
    
}
