//
//  TranslateScreen1ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class TranslateScreen1ViewController: UIViewController {
    
    @IBOutlet weak var translateScreen1Label: UILabel!
    
    @IBOutlet weak var goLabel: UIButton!
    
    @IBAction func translateGoButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = color1
        self.translateScreen1Label.textColor = .white
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
        view.backgroundColor = color1
        self.translateScreen1Label.textColor = .white
        self.goLabel.setTitleColor(.white, for: .normal)
        UINavigationBar.appearance().barTintColor = color5
        UINavigationBar.appearance().tintColor = color6
    }
}
