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
var currencySymbol = "USD"
/// Currency name
var currencyName = ""
/// Empty text as initial value for textToTranslate
var textToTranslate = ""
var allDays: [Int] {
    var array = [Int]()
    for item in 0...39{
        array.append(item)
    }
    return array
}
/// Array that sets the targeted days : each day has 8 weatherObject items
let targetDays = [0, 8, 16, 24, 32]

var color1: UIColor?
var color2: UIColor?
var color3: UIColor?
var color4: UIColor?
var color5: UIColor? = UIColor(hexString: "FAFBF8")
var color6 = UIColor(hexString: "5A616D")

func  navigationBarColor() {
    UINavigationBar.appearance().barTintColor = color5
    UINavigationBar.appearance().tintColor = color6
}
