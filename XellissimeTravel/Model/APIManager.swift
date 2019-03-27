//
//  APIManager.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

/**
 Function that adds a digit when user types a number for the calculation
 - Parameter newNumber: The digit chosen by user on screen
 - Returns: The string to be displayed on screen
 
 # Important Notes #
 0 as first character of the number is not displayed on screen
 */

// MARK: API EndPoint :  variable to switch from one API to another
var myTargetUrl = FixerAPI().endPoint

// MARK: Networking class
class NetworkManager {
    // MARK: Networking properties
    static var shared = NetworkManager()
    private init(){}
    
    // Url to use for API Call
    
    #warning("may be change in not private and var")
    private static let targetUrl = URL(string: myTargetUrl)
    
    
}

