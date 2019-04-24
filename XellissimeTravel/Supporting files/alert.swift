//
//  alert.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 10/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

class Alert{
    static var shared = Alert() 
    init() {}
    enum ListCase {
        case weatherRequestFailed, changeRequestFailed, translationRequestFailed, bigAmount, emptyText, pressSearchFirst
    }
    var controller: UIViewController?
    var alertDisplay :  ListCase = .changeRequestFailed {
        didSet {
           presentAlert(myCase: alertDisplay)
        }
    }
    private func presentAlert(myCase: ListCase){
        switch myCase {
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
extension UIViewController {
    func presentAlertDetails(title: String, message: String, titleButton: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: titleButton, style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
