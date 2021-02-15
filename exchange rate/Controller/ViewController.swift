//
//  ViewController.swift
//  exchange rate
//
//  Created by kittawat phuangsombat on 2020/10/17.
//

import UIKit
import NVActivityIndicatorView

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

    @IBOutlet weak var loading: NVActivityIndicatorView!
    
    var currencyManager = CurrencyManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyTopDisplayed.tag = 1
        currencyBottomDisplayed.tag = 2
        
        setupToolBar()
        initializeHideKeyboard()
        
        currencyManager.delegate = self
        

        //swipe gesture
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(swipeRight)
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    //check internet connection
    if NetworkMonitor.shared.isConnected{
      print("on internet")
    }else{
      print("not on internet")
      let alert = UIAlertController(title: "No internet connection", message: "Please connect to internet to before using the app", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
    
    //MARK: - currency seletion
    @IBAction func chooseCurrencyPressed(_ sender: UIButton){
        tagClick = sender.tag
        activateSegue()
    }
    
    func setCurrency(_ setUpCurrency: Objects)  {
        if tagClick == 1{
            loading.startAnimating()

            currencyTopDisplayed.setTitle(setUpCurrency.unit, for: .normal)
            topCurrencySubtitle.text = setUpCurrency.unitName
            
      
            if convertType.titleLabel?.text == K.convertDown{
                userselect = setUpCurrency.unit
                convertTo = currencyBottomDisplayed.currentTitle
            }else if convertType.titleLabel?.text == K.convertUp{
                userselect = currencyBottomDisplayed.currentTitle
                convertTo = setUpCurrency.unit
            }
            print("top currency seleted")
            print(convertTo as Any)
  
        }else if tagClick == 2{
            loading.startAnimating()

            currencyBottomDisplayed.setTitle(setUpCurrency.unit, for: .normal)
            bottomCurrencySubtitle.text = setUpCurrency.unitName
            
            if convertType.titleLabel?.text == K.convertDown{
                userselect = currencyTopDisplayed.currentTitle
                convertTo = setUpCurrency.unit
            }else if convertType.titleLabel?.text == K.convertUp{
                userselect = setUpCurrency.unit
                convertTo = currencyTopDisplayed.currentTitle
            }
         
            
            print("botom currency seleted")
            print(convertTo as Any)
            
           
            
        }
        refreshCurrency()
    }
    
    func activateSegue() {
        performSegue(withIdentifier: K.pointToCurrency, sender: self)
    }
    
    //MARK: - textfield change
    
    @IBAction func textFieldChange(_ sender: UITextField) {
        
        switch sender {
        case topTextField:
            loading.startAnimating()

            convertType.setTitle(K.convertDown, for: .normal)
            userselect = currencyTopDisplayed.currentTitle
            convertTo = currencyBottomDisplayed.currentTitle
            refreshCurrency()
            
            print("top was selected")
            
            
        case bottomTextField:
            loading.startAnimating()

            convertType.setTitle(K.convertUp, for: .normal)
            userselect = currencyBottomDisplayed.currentTitle
            convertTo = currencyTopDisplayed.currentTitle
            refreshCurrency()
            
            print("bottom was selected")
            
            
        default:
            print("error")
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
        //    use to display if conveert up or nown
        
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
            
            //if top was selected and change
            
            if self.convertType.titleLabel?.text == K.convertDown{
                
                if self.topTextField.text != "" {
                    let topInput = Float(self.topTextField.text!)
                    let calculatedCurrency = currencyObtain*topInput!
                    self.bottomTextField.text = String(format: "%.2f", calculatedCurrency)
                }else{
                    self.topTextField.placeholder = K.amountNeededForInput
                    self.bottomTextField.text = K.blank
                }
            }else if self.convertType.titleLabel?.text == K.convertUp{
                //if bottom was sellected and change
                if self.bottomTextField.text != ""{
                    let bottomInput = Float(self.bottomTextField.text!)
                    let calculatedCurrency = currencyObtain*bottomInput!
                    self.topTextField.text = String(format: "%.2f", calculatedCurrency)
                }else{
                    self.bottomTextField.placeholder = K.amountNeededForInput
                    self.topTextField.text = K.blank
                }
                
            }
            self.loading.stopAnimating()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK: - Swipe gesture

extension ViewController{
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
                performSegue(withIdentifier: K.pointToSetting, sender: self)
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
                performSegue(withIdentifier: K.pointToSetting, sender: self)
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
}
