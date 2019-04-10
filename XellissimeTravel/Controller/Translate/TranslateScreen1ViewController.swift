//
//  TranslateScreen1ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class TranslateScreen1ViewController: UIViewController {
    // MARK: - Outlets - Label
    @IBOutlet weak var translateScreen1Label: UILabel!
    // MARK: - Outlets - Button
    @IBOutlet weak var goLabel: UIButton!
    // MARK: - Actions
    @IBAction func translateGoButton(_ sender: Any) {
    }
    // MARK: - Methods - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color1
        self.translateScreen1Label.textColor = .white
        self.goLabel.setTitleColor(.white, for: .normal)
        navigationBarColor()
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor1, object: nil)
    }
    // MARK: - Methods - ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor1, object: nil)
    }
    // MARK: - Methods
    /**
     Function to update colors of screen, listening to Notification sent from parameters options
     */
    @objc func updateColor(notification : Notification){
        view.backgroundColor = color1
        self.translateScreen1Label.textColor = .white
        self.goLabel.setTitleColor(.white, for: .normal)
        navigationBarColor()
    }
}
