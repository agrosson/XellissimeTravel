//
//  ExtensionUIColor.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 08/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let rrr = Int(color >> 16) & mask
        let ggg = Int(color >> 8) & mask
        let bbb = Int(color) & mask
        let red   = CGFloat(rrr) / 255.0
        let green = CGFloat(ggg) / 255.0
        let blue  = CGFloat(bbb) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    func toHexString() -> String {
        var rrr: CGFloat = 0
        var ggg: CGFloat = 0
        var bbb: CGFloat = 0
        var alph: CGFloat = 0
        getRed(&rrr, green: &ggg, blue: &bbb, alpha: &alph)
        let rgb: Int = (Int)(rrr*255)<<16 | (Int)(ggg*255)<<8 | (Int)(bbb*255)<<0
        return String(format:"#%06x", rgb)
    }
}
