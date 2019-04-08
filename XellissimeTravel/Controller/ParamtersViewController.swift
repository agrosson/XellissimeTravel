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
    
    var color1: UIColor?
    var color2: UIColor?
    var color3: UIColor?
    var color4: UIColor?
    
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
            print("style1")
        case .style2:
            print("style2")
        case .style3:
            print("style3")
        case .style4:
            print("style4")
        }
        
    }
    
    @IBAction func paramtersSegmentedSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0: style = .style1
            case 1: style = .style2
            case 2: style = .style3
            case 3: style = .style4
        default : style = .style1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func redMood() {
        parametersView1.backgroundColor = UIColor(hexString: "E13932")
        parametersView2.backgroundColor = UIColor(hexString: "881313")
        parametersView3.backgroundColor = UIColor(hexString: "FC3B10")
        parametersView4.backgroundColor = UIColor(hexString: "ef5b17")
    }
}

