//
//  FixerAPI.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

class FixerAPI {
    private let endPoint = "http://data.fixer.io/api/latest"
    lazy var urlEndPoint = URL(string: endPoint)
    let httpMethod = "GET"
    private let keyAPI = "123"
    var symbol: String
    lazy var fixerFullUrl:URL? = createFullUrl()
    init(symbol: String){
        self.symbol = symbol
    }
    
    func createFullUrl() -> URL? {
        let endPointUrl = endPoint
        let body = "access_key=\(keyAPI)&base=EUR&symbols=\(symbol)"
        let fullUrl = "\(endPointUrl)?\(body)"
        guard let url = URL(string: fullUrl) else { return nil }
        return url
    }
}

struct ExchangeAnswer: Codable {
    let success: Bool?
    let timestamp: Int?
    let base, date: String?
    let rates: [String:Float]?
}

struct CurrencyDataBase {
    static let dB = ["USD", "GBP", "CAD"]
}
