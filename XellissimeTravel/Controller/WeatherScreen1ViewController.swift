//
//  WeatherScreen1ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 08/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class WeatherScreen1ViewController: UIViewController {

    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var goLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color3
        self.introLabel.textColor = .white
        self.goLabel.setTitleColor(.white, for: .normal)
         UINavigationBar.appearance().barTintColor = color5
        UINavigationBar.appearance().tintColor = color6
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor1, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor1, object: nil)
    }
    @objc func updateColor(notification : Notification){
        view.backgroundColor = color3
        self.introLabel.textColor = .white
        self.goLabel.setTitleColor(.white, for: .normal)
         UINavigationBar.appearance().barTintColor = color5
        UINavigationBar.appearance().tintColor = color6
        
    }
    
}
