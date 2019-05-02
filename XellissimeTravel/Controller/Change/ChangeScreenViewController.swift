//
//  ChangeScreen2ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 28/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class ChangeScreenViewController: UIViewController {
    
    // MARK: - Properties
    /// FX rate
    lazy var rate:Float? = Float(self.rateLabel.text ?? "1")
    /// Currency target for flag: default US
    lazy var currencyTwo = CurrencyDataBase.currencyCountryCode[currencySymbol]![0]
    /// Bundle where Flags images are stored
    let bundle = FlagKit.assetBundle
    /// Image one for flag, initial with currencyOne
    lazy var flagImageOne:UIImage = UIImage.init(named: currencyOne, in: bundle, compatibleWith: nil)!
    /// Image two for flag, initial with CurrencyTwo
    lazy var flagImageTwo:UIImage = UIImage.init(named: currencyTwo, in: bundle, compatibleWith: nil)!
    /// Initial settings for flag One
    lazy var flagOneInitial = flagImageOne
    /// Initial settings for flag Two
    lazy var flagTwoInitial = flagImageTwo
    /// Amount to convert
    lazy var amountToConvert = (textFieldFX.text! as NSString).floatValue
    // MARK: - Outlets - View
     @IBOutlet var popViewFX: UIView!
    // MARK: - Outlets - Labels
    @IBOutlet weak var amountToConvertLabel: UILabel!
    @IBOutlet weak var amountConvertedLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    // MARK: - Outlets - Button
    @IBOutlet weak var goOutlet: UIButton!
    @IBOutlet weak var chooseCurrencyButton: UIButton!
    // MARK: - Outlets - PickerView
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    // MARK: - Outlets - TextField
    @IBOutlet weak var textFieldFX: UITextField!
    
    // MARK: - Outlets - ImageView
    @IBOutlet weak var flagLeft: UIImageView!
    @IBOutlet weak var flagRight: UIImageView!
    
    // MARK: - Outlets - ActivityIndicatorView
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Actions
    /**
     Action that launches request to get FX
     */
    @IBAction func goFXButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        popViewFX.removeFromSuperview()
        flagImageOne = UIImage.init(named: "EU", in: bundle, compatibleWith: nil)!
        flagImageTwo = flagTwoInitial
        // Get currency info from Picker
        let pickerIndex = currencyPicker.selectedRow(inComponent: 0)
        currencySymbol = CurrencyDataBase.dB[pickerIndex]
        if CurrencyDataBase.currencyCountryCode[currencySymbol]!.count > 0 {
           currencyTwo = CurrencyDataBase.currencyCountryCode[currencySymbol]![0]
        }
        if CurrencyDataBase.currencyCountryCode[currencySymbol]!.count > 1 {
             currencyName = CurrencyDataBase.currencyCountryCode[currencySymbol]![1]
        }
        // Set flag from currency choosen
        flagImageTwo = UIImage.init(named: currencyTwo, in: bundle, compatibleWith: nil)!
        // Prepare and send request
        let api = FixerAPI(symbol: currencySymbol)
        guard let fullUrl = api.fixerFullUrl else {
            Alert.shared.controller = self
            Alert.shared.alertDisplay = .changeRequestFailed
            return
        }
        let method = api.httpMethod
        let myFXCall = NetworkManager.shared
        // Block of code to check amount to convert
        checkAmountToConvert()
        //
        myFXCall.getChange(fullUrl: fullUrl, method: method, ToCurrency: api.symbol) { (success, textresult) in
            self.toggleActivityIndicator(shown: false)
            self.rate = textresult
            if textresult != nil {
                self.adaptDecimalDisplay()
                self.rateLabel.text = String(format: "%.4f", textresult!)
                myRateResult = textresult!
                self.amountToConvertLabel.text = String(format: "%.\(decimalMaxToConvert)f", self.amountToConvert)
                self.amountConvertedLabel.text = String(format: "%.\(decimalMaxConverted)f", (self.amountToConvert*myRateResult))
                self.updateFlagImages()
            } else {
                Alert.shared.controller = self
                Alert.shared.alertDisplay = .changeRequestFailed
            }
        }
    }
    // Enable to switch converted amount and amount to convert
    @IBAction func switchCurrencyButton(_ sender: Any) {
        switchFlag()
        switchAmount()
    }
    // Display PopOverView to choose currency in PickerView
    @IBAction func chooseCurrencyButtonPressed(_ sender: Any) {
        self.view.addSubview(popViewFX)
        if Parameter.shared.colors.count > 0 {
             popViewFX.backgroundColor = Parameter.shared.colors[0]
        }
        guard let test = self.tabBarController?.tabBar.frame.height else {return}
        popViewFX.center = CGPoint(x: view.frame.width/2,
                                   y: (view.frame.height-popViewFX.frame.height/2)-test-1)
    }
    // MARK: - Methods - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup colors for the screen
        activityIndicator.isHidden = true
        if Parameter.shared.colors.count > 1 {
           view.backgroundColor = Parameter.shared.colors[1]
        }
        goOutlet.setTitleColor(.white, for: .normal)
        textFieldFX.backgroundColor = .clear
        navigationBarColor()
        popViewFX.layer.cornerRadius = 50
        // Launch function to display weather in New Yorr City, USA
        getUsdWhenLoad()
        // Textfield Delegate
        textFieldFX.delegate = self
        // Creation of tapGestureRecognizer
        gestureTapCreation()
        gestureSwipeCreation()
        // Setup flags
        flagLeft.image = flagImageOne
        flagRight.image = flagImageTwo
        // Add Notification Observer
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor, object: nil)
    }
    // MARK: - Methods - ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor, object: nil)
        getUsdWhenLoad()
        updateFlagImages()
    }
    // MARK: - Methods
    /**
     Function to hide/show indicator activity
     */
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        chooseCurrencyButton.isHidden = shown
    }
    
    /**
     Function to check amount to convert
     */
    private func checkAmountToConvert(){
        if textFieldFX.text == "" || textFieldFX.text == "0" || textFieldFX.text == nil {
            amountToConvert = 1
            textFieldFX.text = "1"
        } else {
            amountToConvert = (textFieldFX.text! as NSString).floatValue
            if amountToConvert == 0 {
                amountToConvert = Float(1)
                textFieldFX.text = "1"
            }
            if amountToConvert > Float(9999) {
                amountToConvert = Float(1)
                Alert.shared.controller = self
                Alert.shared.alertDisplay = .bigAmount
                textFieldFX.text = "1"
            }
        }
        adaptDecimalDisplay()
    }
    /**
     Function to adapt decimal
    */
    private func adaptDecimalDisplay() {
        if self.amountToConvert > 499 || self.amountToConvert.truncatingRemainder(dividingBy: 1) == 0 {
            decimalMaxToConvert = 0
        } else {
            decimalMaxToConvert = 2
        }
        if self.amountToConvert*myRateResult > 499 || self.amountToConvert*myRateResult.truncatingRemainder(dividingBy: 1) == 0 {
            decimalMaxConverted = 0
        } else {
            decimalMaxConverted = 2
        }
    }
    
    /**
     Function to update colors of screen, listening to Notification sent from parameters options
     */
    @objc func updateColor(notification : Notification){
        if Parameter.shared.colors.count > 1 {
            view.backgroundColor = Parameter.shared.colors[1]
        }
        self.goOutlet.setTitleColor(.white, for: .normal)
        self.textFieldFX.backgroundColor = .clear
    }
    /**
     Function to get USD/EUR rate
     */
    private func getUsdWhenLoad(){
        toggleActivityIndicator(shown: true)
        currencySymbol = "USD"
        decimalMaxToConvert = 2
        if CurrencyDataBase.currencyCountryCode[currencySymbol]!.count > 1 {
            currencyName = CurrencyDataBase.currencyCountryCode[currencySymbol]![1]
        }
        let api = FixerAPI(symbol: currencySymbol)
        guard let fullUrl = api.fixerFullUrl else {
            Alert.shared.controller = self
            Alert.shared.alertDisplay = .changeRequestFailed
            return
        }
        let method = api.httpMethod
        let myFXCall = NetworkManager.shared
        myFXCall.getChange(fullUrl: fullUrl, method: method, ToCurrency: api.symbol) { (success, textresult) in
            self.toggleActivityIndicator(shown: false)
            if textresult != nil {
                self.adaptDecimalDisplay()
                self.rateLabel.text = String(format: "%.4f", textresult!)
                myRateResult = textresult!
                self.amountToConvertLabel.text =  String(format: "%.\(decimalMaxToConvert)f", self.amountToConvert)
                self.amountConvertedLabel.text = String(format: "%.\(decimalMaxConverted)f", (self.amountToConvert*myRateResult))
                self.updateFlagImages()
            } else {
                Alert.shared.controller = self
                Alert.shared.alertDisplay = .changeRequestFailed
            }
        }
    }
    /**
     Function that Update screen with flagImage
     */
    private func updateFlagImages(){
        flagLeft.image = flagImageOne
        flagRight.image = flagImageTwo
        currencyLabel.text = currencyName
    }
    /**
     Function that switches amount to convert and converted amount. It calculates also the new rate to use
     */
    private func switchAmount(){
        myRateResult = 1/myRateResult
        rateLabel.text = String(format: "%.4f", myRateResult)
        self.adaptDecimalDisplay()
        self.amountConvertedLabel.text = String(format: "%.\(decimalMaxConverted)f", (amountToConvert*myRateResult))
    }
    /**
     Function that switches flag images
     */
    private func switchFlag(){
        let tempImage = flagImageOne
        flagImageOne = flagImageTwo
        flagImageTwo = tempImage
        flagLeft.image = flagImageOne
        flagRight.image = flagImageTwo
    }
    /**
     Function that creates a tapGestureRecognizer
     */
    private func gestureTapCreation(){
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTap))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(mytapGestureRecognizer)
    }
    /**
     Function that creates a SwipeGestureRecognizer
     */
    private func gestureSwipeCreation(){
        let mySwipeGestureRecognizer =
            UISwipeGestureRecognizer(target: self, action: #selector(myTap))
        mySwipeGestureRecognizer.direction = .down
        self.view.addGestureRecognizer(mySwipeGestureRecognizer)
    }
    /**
     Function that updateAmountConversion
     */
    private func updateAmountConversion(){
        checkAmountToConvert()
        if rate != nil {
            self.rateLabel.text = String(format: "%.4f", rate!)
            let myRate = rate!
            myRateResult = rate!
            self.adaptDecimalDisplay()
            self.amountToConvertLabel.text = String(format: "%.\(decimalMaxToConvert)f", self.amountToConvert)
            self.amountConvertedLabel.text = String(format: "%.\(decimalMaxConverted)f", (self.amountToConvert*myRate))
            flagImageOne = UIImage.init(named: "EU", in: bundle, compatibleWith: nil)!
            flagImageTwo = UIImage.init(named: currencyTwo, in: bundle, compatibleWith: nil)!
            flagLeft.image = flagImageOne
            flagRight.image = flagImageTwo
        }
        // Here set the good flags
        
        textFieldFX.resignFirstResponder()
    }
    
    /**
     Function that creates an action for a tapGestureRecognizer. Dissmiss Keyboard
     */
    @objc func myTap(){
        updateAmountConversion()
    }
}
// MARK: - Extension - TextfieldDelegate
extension ChangeScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateAmountConversion()
        return true
    }
    /// Function that checks numeric character in the textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return replacementText.isValidDouble(maxDecimalPlaces: 2)
    }
    
}
// MARK: - Extension - PickerView Delegate and DataSource
extension ChangeScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyDataBase.dB.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let string = CurrencyDataBase.dB[row]
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
}
// MARK: - Extension - String
extension String {
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true //
        let decimalSeparator = formatter.decimalSeparator ?? "."
        if formatter.number(from: self) != nil {
            let split = self.components(separatedBy: decimalSeparator)
            let digits = split.count == 2 ? split.last ?? "" : ""
            return digits.count <= maxDecimalPlaces
        }
        return false
    }
}


