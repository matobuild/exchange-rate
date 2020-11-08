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
    var otherCurrency = ""
    
    var delegate : CurrencyManagerDelegate?
    
    mutating func fetchCurrency(currency : String, secondCurrency : String) {
        let urlString = "\(currencyURL)\(currency)"
        otherCurrency = secondCurrency
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
            
            print("currency this one was chosen to calculate \(otherCurrency)")
            
            func findCurrency()->(Float){
                switch otherCurrency {
                case "THB":
                    return decodeData.conversion_rates.THB
                case "AED":
                    return decodeData.conversion_rates.AED
                case "ARS":
                    return decodeData.conversion_rates.ARS
                case "AUD":
                    return decodeData.conversion_rates.AUD
                case "BGN":
                    return decodeData.conversion_rates.BGN
                case "BRL":
                    return decodeData.conversion_rates.BRL
                case "BSD":
                    return decodeData.conversion_rates.BSD
                case "CAD":
                    return decodeData.conversion_rates.CAD
                case "CHF":
                    return decodeData.conversion_rates.CHF
                case "CLP":
                    return decodeData.conversion_rates.CLP
                case "CNY":
                    return decodeData.conversion_rates.CNY
                case "COP":
                    return decodeData.conversion_rates.COP
                case "CZK":
                    return decodeData.conversion_rates.CZK
                case "DKK":
                    return decodeData.conversion_rates.DKK
                case "DOP":
                    return decodeData.conversion_rates.DOP
                case "EGP":
                    return decodeData.conversion_rates.EGP
                case "EUR":
                    return decodeData.conversion_rates.EUR
                case "FJD":
                    return decodeData.conversion_rates.FJD
                case "GBP":
                    return decodeData.conversion_rates.GBP
                case "GTQ":
                    return decodeData.conversion_rates.GTQ
                case "HKD":
                    return decodeData.conversion_rates.HKD
                case "HRK":
                    return decodeData.conversion_rates.HRK
                case "HUF":
                    return decodeData.conversion_rates.HUF
                case "IDR":
                    return decodeData.conversion_rates.IDR
                case "ILS":
                    return decodeData.conversion_rates.ILS
                case "INR":
                    return decodeData.conversion_rates.INR
                case "ISK":
                    return decodeData.conversion_rates.ISK
                case "JPY":
                    return decodeData.conversion_rates.JPY
                case "KRW":
                    return decodeData.conversion_rates.KRW
                case "KZT":
                    return decodeData.conversion_rates.KZT
                case "MVR":
                    return decodeData.conversion_rates.MVR
                case "MYR":
                    return decodeData.conversion_rates.MYR
                case "NOK":
                    return decodeData.conversion_rates.NOK
                case "NZD":
                    return decodeData.conversion_rates.NZD
                case "PAB":
                    return decodeData.conversion_rates.PAB
                case "PEN":
                    return decodeData.conversion_rates.PEN
                case "PHP":
                    return decodeData.conversion_rates.PHP
                case "PKR":
                    return decodeData.conversion_rates.PKR
                case "PLN":
                    return decodeData.conversion_rates.PLN
                case "PYG":
                    return decodeData.conversion_rates.PYG
                case "RON":
                    return decodeData.conversion_rates.RON
                case "RUB":
                    return decodeData.conversion_rates.RUB
                case "SAR":
                    return decodeData.conversion_rates.SAR
                case "SEK":
                    return decodeData.conversion_rates.SEK
                case "SGD":
                    return decodeData.conversion_rates.SGD
                case "TRY":
                    return decodeData.conversion_rates.TRY
                case "TWD":
                    return decodeData.conversion_rates.TWD
                case "UAH":
                    return decodeData.conversion_rates.UAH
                case "USD":
                    return decodeData.conversion_rates.USD
                case "UYU":
                    return decodeData.conversion_rates.UYU
                case "ZAR":
                    return decodeData.conversion_rates.ZAR

                default:
                    return 1.000
                }
            }
            let convertCurrencyNumber = findCurrency()
           // let convertCurrencyNumber = decodeData.conversion_rates.THB
            
            let currency = CurrencyModel(baseCurrency: baseCurrency, secondCurrency: otherCurrency, convertCurrencyNumber: convertCurrencyNumber)
            print(currency.baseCurrency)
            print(currency.convertCurrencyNumber)
            
            return currency
        }catch{
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
    
    
    
}
