//
//  Objects.swift
//  exchange rate
//
//  Created by kittawat phuangsombat on 2020/10/18.
//

import UIKit

struct Objects {
    var unit : String!
    var unitName : String!
}

var currency = Currency()
var objectArray = [Objects]()

var currencyDictionary = [String: [Objects]]()


func dictToArray() {
    for (key,value) in currency.currenciesUnit{
        objectArray.append(Objects(unit: key, unitName: value))
    }
}

func arrayCounted()->Int {
    objectArray.count
}

func sortedCurrencies()-> [Objects]  {
    objectArray.sorted(by: { $0.unit < $1.unit })
}

func findCurrencyTitle() -> [String] {
    var currencyTitle = [String]()
    
    for currency in sortedCurrencies(){
        let currencyKey = String(currency.unit.prefix(1))
        currencyTitle.append(currencyKey)
    }
    currencyTitle = currencyTitle.removingDuplicates()
    
    return currencyTitle
}
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

func putCurrencyIntoDictionary(){
    let currencies = sortedCurrencies()
    let dictionary = Dictionary(grouping: currencies, by: { String($0.unit.first!) })
    currencyDictionary = dictionary
}

