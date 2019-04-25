//
//  TranslateScreen2ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 01/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class TranslateScreen2ViewController: UIViewController {

    // MARK: - Outlets - Labels
    @IBOutlet weak var translatedTextLabel: UILabel!
    // MARK: - Outlets - Button
    @IBOutlet weak var translateOutlet: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    // MARK: - Outlets - TextView
    @IBOutlet weak var textTotranslateTextView: UITextView!
    // MARK: - Outlets - ActivityIndicatorView
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Actions
    /**
     Action that clears text in UITextView
     */
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        textTotranslateTextView.text = ""
        translatedTextLabel.text = "YOUR TRANSLATION HERE"
        clearButton.isHidden = true
    }
    /**
     Action that launches resquet to translate text
     */
    @IBAction func translateButton(_ sender: UIButton) {
        toggleActivityIndicator(shown: true)
        var tempText = textTotranslateTextView.text
        tempText?.removeFirstAndLastAndDoubleWhitespace()
        if tempText != "" {
            textTotranslateTextView.text = tempText!
            textToTranslate = tempText!
        } else {
            Alert.shared.controller = self
            Alert.shared.alertDisplay = .emptyText
            if textTotranslateTextView.text.isEmpty {
                translatedTextLabel.text = "YOUR TRANSLATION HERE"
            }
        }
        textTotranslateTextView.resignFirstResponder()
        // Block to prepare request
        let testLangOut = "en"
        let testLangIn = "fr"
        let api = GoogleTranslateAPI(textInput: textToTranslate, targetLanguage: testLangOut, sourceLanguage: testLangIn)
        let method = api.httpMethod
        let body = api.httpBody
        let myTranslateCall = NetworkManager.shared
        let url = api.createFullUrl()
        myTranslateCall.translate(fullUrl: url!, method: method, body: body) { (success, translation) in
            self.toggleActivityIndicator(shown: false)
            if translation != nil{
                self.translatedTextLabel.text = translation!.uppercased()
                if self.textTotranslateTextView.text.isEmpty {
                    self.translatedTextLabel.text = "YOUR TRANSLATION HERE"
                }
            } else {
                if self.textTotranslateTextView.text.isEmpty {
                    self.translatedTextLabel.text = "YOUR TRANSLATION HERE"
                }
                Alert.shared.controller = self
                Alert.shared.alertDisplay = .translationRequestFailed
            }
        }
        if textTotranslateTextView.text.isEmpty {
            translatedTextLabel.text = "YOUR TRANSLATION HERE"
        }
    }
    // MARK: - Methods - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        self.view.backgroundColor = Parameter.shared.colors[0]
        self.translateOutlet.setTitleColor(.white, for: .normal)
        navigationBarColor()
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor, object: nil)
        gestureTapCreation()
        gestureSwipeCreation()
        
        // listen to keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // MARK: - Methods - ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor, object: nil)
    }
    // MARK: - Methods
    /**
     Function to show/hide activity indicator
     */
    private func toggleActivityIndicator(shown: Bool){
        activityIndicator.isHidden = !shown
        translateOutlet.isHidden = shown
    }
    /**
     Function to update colors of screen, listening to Notification sent from parameters options
     */
    @objc func updateColor(notification : Notification){
        self.view.backgroundColor = Parameter.shared.colors[0]
        self.translateOutlet.setTitleColor(.white, for: .normal)
        navigationBarColor()
    }
    // stop listening
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
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
    
    @objc func myTap(){
         textTotranslateTextView.resignFirstResponder()
    }
    /**
     Function that creates an animation to move view up when showing keyboard
     */
    func animUp(keyboardHeight: CGFloat){
        UIView.animate(withDuration: 0.5, animations: {
            self.translateOutlet.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
        }, completion: nil)
    }
}
extension TranslateScreen2ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        clearButton.isHidden = textTotranslateTextView.text.isEmpty
        if textTotranslateTextView.text.isEmpty {
            translatedTextLabel.text = "YOUR TRANSLATION HERE"
        }
        translatedTextLabel.isHidden = true
        translatedTextLabel.text = "YOUR TRANSLATION HERE"
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        translatedTextLabel.isHidden = true
        if textTotranslateTextView.text == "YOUR TEXT HERE" {
            textTotranslateTextView.text = ""
            clearButton.isHidden = true
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            translatedTextLabel.isHidden = false
            return false
        }
        return true
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
        translatedTextLabel.isHidden = false
        if textTotranslateTextView.text.isEmpty {
            translatedTextLabel.text = "YOUR TRANSLATION HERE"
        }
    }
}
