//
//  ChangeSreen1ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class ChangeScreen1ViewController: UIViewController {
    
    @IBOutlet weak var goLabel: UIButton!
    @IBOutlet weak var introLabel: UILabel!
    @IBAction func changeGoButton(_ sender: UIButton) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color2
        self.introLabel.textColor = .white
        goLabel.setTitleColor(.white, for: .normal)
         UINavigationBar.appearance().barTintColor = color5
        UINavigationBar.appearance().tintColor = color6
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor1, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor1, object: nil)
    }
    @objc func updateColor(notification : Notification){

        view.backgroundColor = color2
        self.introLabel.textColor = .white
        goLabel.setTitleColor(.white, for: .normal)
         UINavigationBar.appearance().barTintColor = color5
        UINavigationBar.appearance().tintColor = color6
        
    }
}
