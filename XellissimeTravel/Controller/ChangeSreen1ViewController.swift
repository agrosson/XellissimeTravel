//
//  ChangeSreen1ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class ChangeSreen1ViewController: UIViewController {
    
    @IBAction func changeGoButton(_ sender: UIButton) {
        let api = FixerAPI(symbol: "GBP")
        let fullUrl = api.createFullUrl()
        let method = api.httpMethod
        let myFirstCall = NetworkManager.shared
        myFirstCall.getChange(fullUrl: fullUrl!, method: method, ToCurrency: api.symbol) { (success, textresult) in
            if textresult != nil {
                print(textresult!)
            } else {
                print("Mince encore une erreur")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
