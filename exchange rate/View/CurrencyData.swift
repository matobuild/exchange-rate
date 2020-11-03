//
//  CurrencyData.swift
//  exchange rate
//
//  Created by kittawat phuangsombat on 2020/10/20. 
//

import Foundation

struct CurrencyData : Codable{
    let base_code : String
    let conversion_rates : Rates
}
struct Rates : Codable {
     let THB : Float
     let AED : Float
     let ARS : Float
     let AUD : Float
     let BGN : Float
     let BRL : Float
     let BSD : Float
     let CAD : Float
     let CHF : Float
     let CLP : Float
     let CNY : Float
     let COP : Float
     let CZK : Float
     let DKK : Float
     let DOP : Float
     let EGP : Float
     let EUR : Float
     let FJD : Float
     let GBP : Float
     let GTQ : Float
     let HKD : Float
     let HRK : Float
     let HUF : Float
     let IDR : Float
     let ILS : Float
     let INR : Float
     let ISK : Float
     let JPY : Float
     let KRW : Float
     let KZT : Float
     let MVR : Float
     let MXN : Float
     let MYR : Float
     let NOK : Float
     let NZD : Float
     let PAB : Float
     let PEN : Float
     let PHP : Float
     let PKR : Float
     let PLN : Float
     let PYG : Float
     let RON : Float
     let RUB : Float
     let SAR : Float
     let SEK : Float
     let SGD : Float
     let TRY : Float
     let TWD : Float
     let UAH : Float
     let USD : Float
     let UYU : Float
     let ZAR : Float
}

