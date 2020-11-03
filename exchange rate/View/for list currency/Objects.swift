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





