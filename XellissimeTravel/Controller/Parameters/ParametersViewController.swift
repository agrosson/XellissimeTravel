//
//  ParamtersViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 08/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class ParamtersViewController: UIViewController {
    
    @IBOutlet weak var parametersView1: UIView!
    @IBOutlet weak var parametersView2: UIView!
    @IBOutlet weak var parametersView3: UIView!
    @IBOutlet weak var parametersView4: UIView!
    @IBOutlet weak var parametersView5: UIView!
    

    
    enum Style {
            case style1, style2, style3, style4
    }
    
    var style : Style = .style1 {
        didSet{
            setStyle(style)
        }
    }
    private func setStyle(_ style: Style) {
        switch style {
        case .style1:
            createMood(with: pinkColor)
        case .style2:
            createMood(with: blueColor)
        case .style3:
            createMood(with: modernColor)
        case .style4:
           createMood(with: greenColor)
        }
        
    }
    
    @IBAction func parametersSegmentedControlSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0: style = .style1
            case 1: style = .style2
            case 2: style = .style3
            case 3: style = .style4
        default : style = .style1
        }
        NotificationCenter.default.post(name: .setNewColor1, object: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarColor()
        view.backgroundColor = .black
        style = .style1
        NotificationCenter.default.post(name: .setNewColor1, object: self)
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         NotificationCenter.default.post(name: .setNewColor1, object: self)
    }
    
    private func createMood(with colorArray: [String]) {
        var arrayColor : [UIColor] = []
        for tagnumber in 1...5 {
            self.view.viewWithTag(tagnumber)?.backgroundColor = UIColor(hexString: colorArray[tagnumber-1])
            arrayColor.append(UIColor(hexString: colorArray[tagnumber-1]))
        }
        Parameter.shared.colors = arrayColor
    }
}

