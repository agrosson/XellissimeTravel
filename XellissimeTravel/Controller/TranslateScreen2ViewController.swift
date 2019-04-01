//
//  TranslateScreen2ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 01/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class TranslateScreen2ViewController: UIViewController {
    
    @IBOutlet weak var translateOutlet: UIButton!
    var textToTranslate = ""
    
    @IBOutlet weak var clearButton: UIButton!
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        textTotranslateTextView.text = ""
        clearButton.isHidden = true
    }
    
    @IBOutlet weak var textTotranslateTextView: UITextView!
    @IBOutlet weak var translatedTextLabel: UILabel!
    @IBAction func translateButton(_ sender: UIButton) {
       
        if textTotranslateTextView.text != "" {
            textToTranslate = textTotranslateTextView.text!
        } else {
            alertText()
        }
        
        let testLangOut = "en"
        let testLangIn = "fr"
        let api = GoogleTranslateAPI(textInput: textToTranslate, targetLanguage: testLangOut, sourceLanguage: testLangIn)
        let method = api.httpMethod
        let body = api.httpBody
        let myTranslateCall = NetworkManager.shared
        let url = api.createFullUrl()
        myTranslateCall.translate(fullUrl: url!, method: method, body: body) { (success, translation) in
            if translation != nil{
                print(translation!)
                self.translatedTextLabel.text = translation?.uppercased()
                
            } else {
                print("une erreur de traduction")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureTapCreation()
       
        // listen to keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // stop listening
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    private func alertText(){
        let actionSheet = UIAlertController(title: "Warning", message: "Your text is empty", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion : nil)
    }
    
    /**
     Function that creates a tapGestureRecognizer
     */
    private func gestureTapCreation(){
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTap))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(mytapGestureRecognizer)
    }
    @objc func myTap(){
         textTotranslateTextView.resignFirstResponder()
    }
    
    func animUp(keyboardHeight: CGFloat){
        UIView.animate(withDuration: 0.5, animations: {
            self.translateOutlet.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
        }, completion: nil)
        }
}
extension TranslateScreen2ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        clearButton.isHidden = textTotranslateTextView.text.isEmpty
        textTotranslateTextView.text =  textTotranslateTextView.text.uppercased()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textTotranslateTextView.text == "YOUR TEXT HERE" {
            textTotranslateTextView.text = ""
            clearButton.isHidden = true
        }
    }
}

// Notification protocole for keyboard behavior
extension  TranslateScreen2ViewController {
    @objc func keyboardWillChange(notification: Notification){
        // Get the size of the keyboard
        guard let keyBoardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        // Move the view up with keyboard height
        animUp(keyboardHeight: keyBoardSize.height-view.safeAreaInsets.bottom)
           // clearButton.frame.origin.y = -keyBoardSize.height
    }
    
    @objc func keyboardWillChangeHide(notification: Notification){
        translateOutlet.transform = .identity
    }



}
