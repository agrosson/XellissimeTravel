//
//  StringExtension.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 16/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation

extension String {
    mutating func removeFirstAndLastAndDoubleWhitespace() {
        var newString = self
        repeat{
            if newString.last == " " {
                newString = String(newString.dropLast())
            }
            if newString.first == " " {
                newString = String(newString.dropFirst())
            }
        }
            while newString.first == " " || newString.last == " "
        repeat { newString = newString.replacingOccurrences(of: "  ", with: " ")
        } while newString.contains("  ")
        self =  newString
    }
}
