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
        
        let myFirstCall = NetworkManager.shared
        print("CHANGE SCREEN étape 2")
        myFirstCall.ChangeRequest(completionHandler: { (rateLevel) in
            print("CHANGE SCREEN étape 3")
            if rateLevel != nil {
                 print(rateLevel!)
            } else {
                print("putain d'erreur")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
