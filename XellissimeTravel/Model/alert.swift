//
//  alert.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 10/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

 // MARK: - Class Alert
/**
 This class enables presentation of an alert what ever the viewController
 */
class Alert{
    // MARK: - Properties
    /// ViewController on which the alert will be displayed (self)
    var controller: UIViewController?
    /// Variable that tracks the case of alert
    var alertDisplay :  AlertCase = .changeRequestFailed {
        didSet {
            presentAlert(alertCase: alertDisplay)
        }
    }
    /// Singleton Object
    static var shared = Alert()
     // MARK: - Enum
    /// Enum that lists all cases of alert presentations
    enum AlertCase {
        case weatherRequestFailed, changeRequestFailed, translationRequestFailed, bigAmount, emptyText, pressSearchFirst
    }
    // MARK: -
    init() {}
     // MARK: - Methods
    /**
     Function that presents an alert with defined text depending on AlertCase
     - Parameter myCase: variable used to set text of the alert
     */
    
    private func presentAlert(alertCase: AlertCase){
        switch alertCase {
        case .weatherRequestFailed:
            controller?.presentAlertDetails(title: "Sorry",
                                            message: "The request to get weather forecast failed.",
                                            titleButton: "OK")
        case .changeRequestFailed :
            controller?.presentAlertDetails(title: "Sorry",
                                            message: "The request to get FX failed.",
                                            titleButton: "OK")
        case .translationRequestFailed:
            controller?.presentAlertDetails(title: "Sorry",
                                            message: "The request to translate failed.",
                                            titleButton: "OK")
        case .bigAmount:
            controller?.presentAlertDetails(title: "Sorry",
                                            message: "The amount to change is to big. Change your data",
                                            titleButton: "OK")
        case .emptyText:
            controller?.presentAlertDetails(title: "Sorry",
                                            message: "Your text is empty",
                                            titleButton: "OK")
            
        case . pressSearchFirst:
            controller?.presentAlertDetails(title: "Sorry",
                                            message: "Press Search first",
                                            titleButton: "OK")
        }
    }
}
// MARK: - Extension
extension UIViewController {
    /**
     Function that presents an alert 
     */
    func presentAlertDetails(title: String, message: String, titleButton: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: titleButton, style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
