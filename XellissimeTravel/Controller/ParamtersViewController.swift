//
//  ParamtersViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 08/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

var color1: UIColor?
var color2: UIColor?
var color3: UIColor?
var color4: UIColor?
var color5: UIColor?
var color6 = UIColor(hexString: "5A616D")

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
            getColors()
        }
    }
    private func setStyle(_ style: Style) {
        switch style {
        case .style1:
           pinkMood()
        case .style2:
            blueMood()
        case .style3:
            modernMood()
        case .style4:
           greenMood()
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
        NotificationCenter.default.post(name: .setNewColor1, object: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        style = .style1
        getColors()
        NotificationCenter.default.post(name: .setNewColor1, object: self)
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         NotificationCenter.default.post(name: .setNewColor1, object: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
          NotificationCenter.default.post(name: .setNewColor1, object: self)
    }
    
    private func blueMood() {
       // view.backgroundColor = .black
        parametersView1.backgroundColor = UIColor(hexString: "4B8AEF")
        parametersView2.backgroundColor = UIColor(hexString: "CCCFE8")
        parametersView3.backgroundColor = UIColor(hexString: "99BAED")
        parametersView4.backgroundColor = UIColor(hexString: "869DE1")
        parametersView5.backgroundColor = UIColor(hexString: "FAFBF8")
    }
    private func modernMood() {
     //   view.backgroundColor = .white
        parametersView1.backgroundColor = UIColor(hexString: "142242")
        parametersView2.backgroundColor = UIColor(hexString: "93A3B4")
        parametersView3.backgroundColor = UIColor(hexString: "2278AB")
        parametersView4.backgroundColor = UIColor(hexString: "B5613C")
        parametersView5.backgroundColor = UIColor(hexString: "FAFBF8" )
    }
    private func greenMood() {
       // view.backgroundColor = .lightGray
        parametersView1.backgroundColor = UIColor(hexString: "263023")
        parametersView2.backgroundColor = UIColor(hexString: "7D8861")
        parametersView3.backgroundColor = UIColor(hexString: "ABCF3B")
        parametersView4.backgroundColor = UIColor(hexString: "45821F")
        parametersView5.backgroundColor = UIColor(hexString: "FAFBF8")
    }
    private func pinkMood() {
    //    view.backgroundColor = .lightGray
        parametersView1.backgroundColor = UIColor(hexString: "E63A5B")
        parametersView5.backgroundColor = UIColor(hexString: "FAFBF8")
        parametersView2.backgroundColor = UIColor(hexString: "E69CA9")
        parametersView3.backgroundColor = UIColor(hexString: "AB4687")
        parametersView4.backgroundColor = UIColor(hexString: "D89A58")
        
    }
    
    private func getColors() {
        color1 =  parametersView1.backgroundColor
        color2 =  parametersView2.backgroundColor
        color3 =  parametersView3.backgroundColor
        color4 =  parametersView4.backgroundColor
        color5 =  parametersView5.backgroundColor
    }
}

