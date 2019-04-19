//
//  Settings.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 10/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

/// Initial exchange rate set at 1
var myRateResult: Float = 1
/// Currency for flag: default EUR
var currencyOne = "EU"
/// Currency Symbol
var currencySymbol = "US"
/// Currency name
var currencyName = ""
/// Empty text as initial value for textToTranslate
var textToTranslate = ""

// Array of colors
let blueColor = ["4B8AEF","CCCFE8","99BAED","869DE1","FAFBF8"]
let modernColor = ["142242","93A3B4","2278AB","B5613C","FAFBF8"]
let pinkColor = ["E63A5B","E69CA9","AB4687","D89A58", "FAFBF8"]
let greenColor = ["263023","7D8861","ABCF3B","45821F","FAFBF8"]


//var color1: UIColor?
//var color2: UIColor?
//var color3: UIColor?
//var color4: UIColor?
//var color5: UIColor? = UIColor(hexString: "FAFBF8")
var color6 = UIColor(hexString: "5A616D")

func  navigationBarColor() {
    UINavigationBar.appearance().barTintColor = Parameter.shared.colors[4]
    UINavigationBar.appearance().tintColor = color6
}

class  Parameter {
  static var shared = Parameter()
    init(){
        colors = []
        fillColorsArray()
    }
    var colors: [UIColor] = []
    func fillColorsArray(){
        for index in 0...blueColor.count-1 {
        colors.append(UIColor(hexString: pinkColor[index]))
    }
}
}
