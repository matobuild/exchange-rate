//
//  currencyController.swift
//  exchange rate
//
//  Created by kittawat phuangsombat on 2020/10/17.
//

import UIKit

class currencyController: UIViewController, UITableViewDelegate,UITableViewDataSource{
 
    let cellReuseIdentifier = K.neededCell
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        dictToArray()
    }

    //number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCounted()
    }
    
    //create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyCustomCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MyCustomCell
        
        let sortedCurrency = sortedCurrencies()

        cell.myCurrencyCellLabel.text = sortedCurrency[indexPath.row].unit
        
        cell.currencyFullName.text = sortedCurrency[indexPath.row].unitName
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        let tapCurrency = getTap(index: indexPath)
        
 
      
        //clear all array
        objectArray.removeAll()
        
        if let vc = presentingViewController as? ViewController{
            dismiss(animated: true) {
                vc.setCurrency(tapCurrency)
            }
            
        }
        
    
    }
 

    func getTap(index: IndexPath) -> Objects {
        let currencyInitial = sortedCurrencies()[index.row].unit!
        let currencyFullName = sortedCurrencies()[index.row].unitName!
        let object = Objects(unit: currencyInitial, unitName: currencyFullName    )
        return object
    }
 
}

