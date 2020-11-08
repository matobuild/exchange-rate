//
//  ViewController.swift
//  exchange rate
//
//  Created by kittawat phuangsombat on 2020/10/17.
//

import UIKit

class ViewController: UIViewController {
    
    var tagClick : Int = 0
    var userselect : String?
    var convertTo : String?
   

    @IBOutlet weak var currencyTopDisplayed: UIButton!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var topCurrencySubtitle: UILabel!
    @IBOutlet weak var convertType: UIButton!
    @IBOutlet weak var currencyBottomDisplayed: UIButton!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var bottomCurrencySubtitle: UILabel!
   
    var currencyManager = CurrencyManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyTopDisplayed.tag = 1
        currencyBottomDisplayed.tag = 2
        
        setupToolBar()
        initializeHideKeyboard()
        
        currencyManager.delegate = self
        
    }
    
    //MARK: - currency seletion
    @IBAction func chooseCurrencyPressed(_ sender: UIButton){
        tagClick = sender.tag
        activateSegue()
    }
 
    func setCurrency(_ setUpCurrency: Objects)  {
        if tagClick == 1{
            currencyTopDisplayed.setTitle(setUpCurrency.unit, for: .normal)
            topCurrencySubtitle.text = setUpCurrency.unitName
            
            //this give us what the user select
            userselect = setUpCurrency.unit
            convertTo = currencyBottomDisplayed.currentTitle
            
            print("top currency seleted")
            print(convertTo as Any)
            
            refreshCurrency()
           
                        
        }else if tagClick == 2{
            currencyBottomDisplayed.setTitle(setUpCurrency.unit, for: .normal)
            bottomCurrencySubtitle.text = setUpCurrency.unitName
            //userselect = setUpCurrency.unit
           convertTo = currencyBottomDisplayed.currentTitle
            
            print("botom currency seleted")
          //  print(convertTo as Any)
            
            refreshCurrency()
            
        }
    }
    
    func activateSegue() {
        performSegue(withIdentifier: K.pointToCurrency, sender: self)
    }
    
    //MARK: - textfield change
    
    @IBAction func textFieldChange(_ sender: UITextField) {
        
        switch sender {
        case topTextField:
            userselect = currencyTopDisplayed.currentTitle
            convertTo = currencyBottomDisplayed.currentTitle
            refreshCurrency()
           
            print("top was selected")
            
        case bottomTextField:
           // userselect = currencyBottomDisplayed.currentTitle
            //convertTo = currencyTopDisplayed.currentTitle
           refreshCurrency()
            print("bottom was selected")
            
        default:
            print("wtf")
        }
    }
    
}

//MARK: - numpad

extension ViewController {
  
    //tap outside key to dismiss numpad
    func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //create the done button
    func setupToolBar() {
        let bar = UIToolbar()
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissMyKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil   )
        bar.items = [flexSpace, flexSpace, doneBtn]
        bar.sizeToFit()
        topTextField.inputAccessoryView = bar
        bottomTextField.inputAccessoryView = bar
    }
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
}

//MARK: - convert pressed

extension ViewController{
    
    @IBAction func convertPressed(_ sender: UIButton) {
//        convert from top to bottom and bottom to top
        convertType.setTitle("conver down", for: .normal)
        
        }
    func refreshCurrency()  {
        currencyManager.fetchCurrency(currency: userselect ?? "cny", secondCurrency: convertTo ?? "thb" )
        
    }
    
        
}


//MARK: - currencyManager Delegate

extension ViewController : CurrencyManagerDelegate{
    func didUpdateCurrency(_ currencyManager: CurrencyManager, currency: CurrencyModel) {
        DispatchQueue.main.async {
        
            let currencyObtain = currency.convertCurrencyNumber
            
   
            if self.topTextField.text != "" {
                let topInput = Float(self.topTextField.text!)
                self.bottomTextField.text = String(currencyObtain*topInput!)
            }else{
                self.topTextField.placeholder = K.amountNeededForInput
                self.bottomTextField.text = K.blank
            }
            
//
//            if self.bottomTextField.text != ""{
//                let bottomInput = Float(self.bottomTextField.text!)
//                self.topTextField.text = String(currencyObtain*bottomInput!)
//            }else{
//                self.bottomTextField.placeholder = "input amount"
//                self.topTextField.text = ""
//            }

            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
   
    
}

