//
//  ChangeSreen1ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class ChangeScreen1ViewController: UIViewController {
    
    // MARK: - Outlets - Label
     @IBOutlet weak var introLabel: UILabel!
    // MARK: - Outlets - Button
    @IBOutlet weak var goLabel: UIButton!
   // MARK: - Actions
    @IBAction func changeGoButton(_ sender: UIButton) {
    }
     // MARK: - Methods - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if Parameter.shared.colors.count > 1 {
           view.backgroundColor = Parameter.shared.colors[1]
        }
        self.introLabel.textColor = .white
        goLabel.setTitleColor(.white, for: .normal)
        navigationBarColor()
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor, object: nil)
    }
    // MARK: - Methods - ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor, object: nil)
    }
    // MARK: - Methods
    /**
     Function to update colors of screen, listening to Notification sent from parameters options
     */
    @objc func updateColor(notification : Notification){
        if Parameter.shared.colors.count > 1 {
            view.backgroundColor = Parameter.shared.colors[1]
        }
        self.introLabel.textColor = .white
        goLabel.setTitleColor(.white, for: .normal)
        navigationBarColor()
    }
}
