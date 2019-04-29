//
//  ParamtersViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 08/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit
/**
 This class enables the user to choose the mood of the application
 */
class ParamtersViewController: UIViewController {
    // MARK: - Outlets - UIViews
    @IBOutlet weak var parametersView1: UIView! // tagnumber 1
    @IBOutlet weak var parametersView2: UIView! // tagnumber 2
    @IBOutlet weak var parametersView3: UIView! // tagnumber 3
    @IBOutlet weak var parametersView4: UIView! // tagnumber 4
    @IBOutlet weak var parametersView5: UIView! // tagnumber 5
    
    @IBOutlet weak var segmentedControlObject: UISegmentedControl!
    
    // MARK: - Properties
    /// Variable that tracks style
    var styleString: String = SettingsService.style {
        didSet {
            setStyleString(styleString)
        }
    }
    // MARK: - Actions
    /**
     Action that sets style depending on segment chosen
     */
    @IBAction func parametersSegmentedControlSelected(_ sender: UISegmentedControl) {
        // style is set from segment selected
        switch sender.selectedSegmentIndex {
        case 0: styleString = "pink"
        case 1: styleString = "blue"
        case 2: styleString = "modern"
        case 3: styleString = "green"
        default : styleString = "pink"
        }
        // Notification is posted after segment is selected
        NotificationCenter.default.post(name: .setNewColor, object: self)
        // Save user preference
        UserDefaults.standard.set(styleString, forKey: "style")
    }
    // MARK: - Methods - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarColor()
        view.backgroundColor = .black
        styleString = SettingsService.style
        // Notification posted here because first screen displayed (default color mood)
        NotificationCenter.default.post(name: .setNewColor, object: self)
    }
    // MARK: - Methods
    /**
     Function that sets colors depending on style chosen
     - Parameter styleString: variable used to set style
     # Important Notes #
     - The selectedSegmentIndex is updated with UserDefault
     */
    private func setStyleString(_ styleString: String) {
        switch styleString {
        case "pink":
            createMood(with: pinkColor)
            self.segmentedControlObject.selectedSegmentIndex = 0
        case "blue":
            createMood(with: blueColor)
            self.segmentedControlObject.selectedSegmentIndex = 1
        case "modern":
            createMood(with: modernColor)
            self.segmentedControlObject.selectedSegmentIndex = 2
        case "green":
            createMood(with: greenColor)
            self.segmentedControlObject.selectedSegmentIndex = 3
        default:
            createMood(with: pinkColor)
            self.segmentedControlObject.selectedSegmentIndex = 0
        }
    }
    /**
     Function that creates an array of colors from an array of Strings
     Sets views with colors
     - Parameter colorArray: Array of string to define UIColor
     */
    private func createMood(with colorArray: [String]) {
        var arrayColor : [UIColor] = []
        for tagnumber in 1...5 {
            self.view.viewWithTag(tagnumber)?.backgroundColor = UIColor(hexString: colorArray[tagnumber-1])
            arrayColor.append(UIColor(hexString: colorArray[tagnumber-1]))
        }
        // update parameters colors
        Parameter.shared.colors = arrayColor
    }
}

