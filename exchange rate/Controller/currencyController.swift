//
//  currencyController.swift
//  exchange rate
//
//  Created by kittawat phuangsombat on 2020/10/17.
//

import UIKit
import AVFoundation

class currencyController: UIViewController, UITableViewDelegate,UITableViewDataSource{
  
  var finishConvertingSoundEffect: AVAudioPlayer?
    
    let cellReuseIdentifier = K.neededCell
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        dictToArray()
        putCurrencyIntoDictionary()
        
    }
    
    //number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currencyKey = findCurrencyTitle()[section]
        if let currencyValues = currencyDictionary[currencyKey]{
            return currencyValues.count
        }
        return 0
        
    }
    
    //create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyCustomCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MyCustomCell
        
        let currencyKey = findCurrencyTitle()[indexPath.section]
        if let currencyValue = currencyDictionary[currencyKey]{
            cell.myCurrencyCellLabel.text = currencyValue[indexPath.row].unit
            cell.currencyFullName.text = currencyValue[indexPath.row].unitName
        }
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
        let currencyKey = findCurrencyTitle()[index.section]
        var currencyInitial = String()
        var currencyFullName = String()
        if let currencyValue = currencyDictionary[currencyKey]{
             currencyInitial = currencyValue[index.row].unit!
             currencyFullName = currencyValue[index.row].unitName!
        }
        let object = Objects(unit: currencyInitial, unitName: currencyFullName    )
      playSound()
        return object
    }
  
  func playSound() {
    let path = Bundle.main.path(forResource: "select.mp3", ofType: nil)!
    let url = URL(fileURLWithPath: path)
    do{
      finishConvertingSoundEffect = try AVAudioPlayer(contentsOf: url)
      finishConvertingSoundEffect?.play()
    }catch{
      fatalError("cant load sound")
    }
  }
  
}
//MARK: - add title
extension currencyController{
    
    // adding section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return findCurrencyTitle().count
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        let sortedCurrency = findCurrencyTitle()
        let currencySectionTitles = sortedCurrency[section]
        return currencySectionTitles
    }
    
    //    Adding the Section Index
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        findCurrencyTitle()
    }
    
    func tableView(_ tableView: UITableView,
                   sectionForSectionIndexTitle title: String,
                   at index: Int) -> Int {
        index
    }
    
}

