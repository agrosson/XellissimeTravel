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
    @IBOutlet weak var parametersView1: UIView!
    @IBOutlet weak var parametersView2: UIView!
    @IBOutlet weak var parametersView3: UIView!
    @IBOutlet weak var parametersView4: UIView!
    
    
    @IBOutlet weak var parametersView5: UIView!
    // MARK: - Enum
    /// Enumeration that lists color styles of the application
    enum Style {
        case pinkStyle, blueStyle, modernStyle, greenStyle
    }
    // MARK: - Properties
    /// Variable that tracks style
    var style : Style = .pinkStyle {
        didSet{
            setStyle(style)
        }
    }
    // MARK: - Actions
    /**
     Action that sets style depending on segment chosen
     */
    @IBAction func parametersSegmentedControlSelected(_ sender: UISegmentedControl) {
        // style is set from segment selected
        switch sender.selectedSegmentIndex {
        case 0: style = .pinkStyle
        case 1: style = .blueStyle
        case 2: style = .modernStyle
        case 3: style = .greenStyle
        default : style = .pinkStyle
        }
        // Notification is posted after segment is selected
        NotificationCenter.default.post(name: .setNewColor, object: self)
    }
    // MARK: - Methods - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarColor()
        view.backgroundColor = .black
        style = .pinkStyle
        // Notification posted here because first screen displayed (default color mood)
        NotificationCenter.default.post(name: .setNewColor, object: self)
    }
    // MARK: - Methods
    /**
     Function that sets colors depending on style chosen
     - Parameter style: variable used to set Style
     */
    private func setStyle(_ style: Style) {
        switch style {
        case .pinkStyle:
            createMood(with: pinkColor)
        case .blueStyle:
            createMood(with: blueColor)
        case .modernStyle:
            createMood(with: modernColor)
        case .greenStyle:
            createMood(with: greenColor)
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
        Parameter.shared.colors = arrayColor
    }
}

