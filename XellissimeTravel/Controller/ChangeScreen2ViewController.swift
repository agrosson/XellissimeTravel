//
//  ChangeScreen2ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 28/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class ChangeScreen2ViewController: UIViewController {
    lazy var amountToConvert = (textFieldFX.text! as NSString).floatValue
    var myRateResult: Float = 1
    @IBOutlet weak var amountToConvertLabel: UILabel!
    
    @IBOutlet weak var amountConvertedLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBAction func goFXButton(_ sender: Any) {
        amountToConvert = (textFieldFX.text! as NSString).floatValue
        let pickerIndex = currencyPicker.selectedRow(inComponent: 0)
        let currencySymbol = CurrencyDataBase.dB[pickerIndex]

        
        flagLeft.image = flagOneInitial
        flagRight.image = flagTwoInitial
        flagImageOne = flagOneInitial
        flagImageTwo = flagTwoInitial
        
        let api = FixerAPI(symbol: currencySymbol)
        let fullUrl = api.createFullUrl()
        let method = api.httpMethod
        let myFirstCall = NetworkManager.shared
        myFirstCall.getChange(fullUrl: fullUrl!, method: method, ToCurrency: api.symbol) { (success, textresult) in
            if textresult != nil {
                self.rateLabel.text = String(format: "%.4f", textresult!)
                self.myRateResult = textresult!
                self.amountToConvertLabel.text = String(format: "%.2f", self.amountToConvert)
                self.amountConvertedLabel.text = String(format: "%.2f", (self.amountToConvert*self.myRateResult))
                print(textresult!)
            } else {
                print("Mince encore une erreur")
            }
        }
    }
    
    @IBAction func switchCurrencyButton(_ sender: Any) {
        switchFlag()
        switchAmount()
    }
    @IBOutlet weak var textFieldFX: UITextField!
    
   @IBOutlet weak var flagLeft: UIImageView!
    
    @IBOutlet weak var flagRight: UIImageView!
    
    @IBOutlet weak var rateLabel: UILabel!
    var currencyOne = "EU"
    var currencyTwo = "US"
    let bundle = FlagKit.assetBundle
    lazy var flagImageOne:UIImage = UIImage.init(named: currencyOne, in: bundle, compatibleWith: nil)!
    lazy var flagImageTwo:UIImage = UIImage.init(named: currencyTwo, in: bundle, compatibleWith: nil)!
    lazy var flagOneInitial = flagImageOne
    lazy var flagTwoInitial = flagImageTwo
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldFX.delegate = self
        gestureTapCreation()
        flagLeft.image = flagImageOne
        flagRight.image = flagImageTwo
        
       
        // Do any additional setup after loading the view.
    }
    private func switchAmount(){
        myRateResult = 1/myRateResult
        rateLabel.text = String(format: "%.4f", myRateResult)
        self.amountConvertedLabel.text = String(format: "%.2f", (amountToConvert*myRateResult))
        
    }
    private func switchFlag(){
        let tempImage = flagImageOne
        flagImageOne = flagImageTwo
        flagImageTwo = tempImage
        flagLeft.image = flagImageOne
        flagRight.image = flagImageTwo
    }
    
    private func gestureTapCreation(){
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTap))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(mytapGestureRecognizer)
    }
    @objc func myTap(){
        textFieldFX.resignFirstResponder()
    }
}

extension ChangeScreen2ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    // Function that checks numeric character in the textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return replacementText.isValidDouble(maxDecimalPlaces: 2)
    }
}

// Alert
extension ChangeScreen2ViewController {
    func alertNonNumeric() {
        let actionSheet = UIAlertController(title: "Attention", message: "Amount should be numeric", preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion : nil)
    }
}

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
extension ChangeScreen2ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyDataBase.dB.count
    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return CurrencyDataBase.dB[row]
//    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let string = CurrencyDataBase.dB[row]
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
}
