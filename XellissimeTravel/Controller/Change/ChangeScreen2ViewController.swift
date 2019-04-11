//
//  ChangeScreen2ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 28/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class ChangeScreen2ViewController: UIViewController {
    
    // MARK: - Properties
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
    
    // MARK: - Outlets - Labels
    @IBOutlet weak var amountToConvertLabel: UILabel!
    @IBOutlet weak var amountConvertedLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    // MARK: - Outlets - Button
    @IBOutlet weak var goOutlet: UIButton!
    // MARK: - Outlets - PickerView
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    // MARK: - Outlets - TextField
    @IBOutlet weak var textFieldFX: UITextField!
    
    // MARK: - Outlets - ImageView
    @IBOutlet weak var flagLeft: UIImageView!
    @IBOutlet weak var flagRight: UIImageView!
    
    // MARK: - Actions
    /**
     Action that launches request to get FX
     */
    @IBAction func goFXButton(_ sender: Any) {
        flagImageOne = flagOneInitial
        flagImageTwo = flagTwoInitial
        // Get currency info from Picker
        let pickerIndex = currencyPicker.selectedRow(inComponent: 0)
        currencySymbol = CurrencyDataBase.dB[pickerIndex]
        currencyTwo = CurrencyDataBase.currencyCountryCode[currencySymbol]![0]
        currencyName = CurrencyDataBase.currencyCountryCode[currencySymbol]![1]
        // Set flag from currency choosen
        flagImageTwo = UIImage.init(named: currencyTwo, in: bundle, compatibleWith: nil)!
        // Prepare and send request
        let api = FixerAPI(symbol: currencySymbol)
        let fullUrl = api.createFullUrl()
        let method = api.httpMethod
        let myFXCall = NetworkManager.shared
        // Block of code to check amount to convert
        checkAmountToConvert()
        //
        myFXCall.getChange(fullUrl: fullUrl!, method: method, ToCurrency: api.symbol) { (success, textresult) in
            if textresult != nil {
                self.rateLabel.text = String(format: "%.4f", textresult!)
                myRateResult = textresult!
                self.amountToConvertLabel.text = String(format: "%.2f", self.amountToConvert)
                self.amountConvertedLabel.text = String(format: "%.2f", (self.amountToConvert*myRateResult))
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
    // MARK: - Methods - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup colors for the screen
        view.backgroundColor = color2
        goOutlet.setTitleColor(.white, for: .normal)
        textFieldFX.backgroundColor = .clear
        navigationBarColor()
        // Launch function to display weather in New Yorr City, USA
        getUsdWhenLoad()
        // Textfield Delegate
        textFieldFX.delegate = self
        // Creation of tapGestureRecognizer
        gestureTapCreation()
        // Setup flags
        flagLeft.image = flagImageOne
        flagRight.image = flagImageTwo
        // Add Notification Observer
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor1, object: nil)
    }
    // MARK: - Methods - ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor1, object: nil)
    }
    // MARK: - Methods
    /**
     Function to check amount to convert
     */
    private func checkAmountToConvert(){
        if textFieldFX.text == "" || textFieldFX.text == "0" {
            amountToConvert = 1
            textFieldFX.text = "1"
        } else {
            amountToConvert = (textFieldFX.text! as NSString).floatValue
            if amountToConvert == 0 {
                amountToConvert = Float(1)
                textFieldFX.text = "1"
            }
            if amountToConvert > Float(100000) {
                amountToConvert = Float(1)
                Alert.shared.controller = self
                Alert.shared.alertDisplay = .bigAmount
                textFieldFX.text = "1"
            }
        }
    }
    /**
     Function to update colors of screen, listening to Notification sent from parameters options
     */
    @objc func updateColor(notification : Notification){
        view.backgroundColor = color2
        self.goOutlet.setTitleColor(.white, for: .normal)
        self.textFieldFX.backgroundColor = .clear
    }
    /**
     Function to get USD/EUR rate
     */
    private func getUsdWhenLoad(){
        let api = FixerAPI(symbol: currencySymbol)
        let fullUrl = api.createFullUrl()
        let method = api.httpMethod
        let myFXCall = NetworkManager.shared
        myFXCall.getChange(fullUrl: fullUrl!, method: method, ToCurrency: api.symbol) { (success, textresult) in
            if textresult != nil {
                self.rateLabel.text = String(format: "%.4f", textresult!)
                myRateResult = textresult!
                self.amountToConvertLabel.text = String(format: "%.2f", self.amountToConvert)
                self.amountConvertedLabel.text = String(format: "%.2f", (self.amountToConvert*myRateResult))
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
        self.amountConvertedLabel.text = String(format: "%.2f", (amountToConvert*myRateResult))
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
     Function that creates an action for a tapGestureRecognizer. Dissmiss Keyboard
     */
    @objc func myTap(){
        textFieldFX.resignFirstResponder()
    }
}
// MARK: - Extension - TextfieldDelegate
extension ChangeScreen2ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldFX.resignFirstResponder()
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
extension ChangeScreen2ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
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

