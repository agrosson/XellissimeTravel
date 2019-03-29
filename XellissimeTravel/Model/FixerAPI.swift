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
    static let dB = ["USD", "GBP", "CAD", "AED",
                     "AFN",
                     "ALL",
                     "AMD",
                     "ANG",
                     "AOA",
                     "ARS",
                     "AUD",
                     "AWG",
                     "AZN",
                     "BAM",
                     "BBD",
                     "BDT",
                     "BGN",
                     "BHD",
                     "BIF",
                     "BMD",
                     "BND",
                     "BOB",
                     "BRL",
                     "BSD",
                     "BTC",
                     "BTN",
                     "BWP",
                     "BYR",
                     "BYN",
                     "BZD",
                     "CAD",
                     "CDF",
                     "CHF",
                     "CLF",
                     "CLP",
                     "CNY",
                     "COP",
                     "CRC",
                     "CUC",
                     "CUP",
                     "CVE",
                     "CZK",
                     "DJF",
                     "DKK",
                     "DOP",
                     "DZD",
                     "EGP",
                     "ERN",
                     "ETB",
                     "EUR",
                     "FJD",
                     "FKP",
                     "GBP",
                     "GEL",
                     "GGP",
                     "GHS",
                     "GIP",
                     "GMD",
                     "GNF",
                     "GTQ",
                     "GYD",
                     "HKD",
                     "HNL",
                     "HRK",
                     "HTG",
                     "HUF",
                     "IDR",
                     "ILS",
                     "IMP",
                     "INR",
                     "IQD",
                     "IRR",
                     "ISK",
                     "JEP",
                     "JMD",
                     "JOD",
                     "JPY",
                     "KES",
                     "KGS",
                     "KHR",
                     "KMF",
                     "KPW",
                     "KRW",
                     "KWD",
                     "KYD",
                     "KZT",
                     "LAK",
                     "LBP",
                     "LKR",
                     "LRD",
                     "LSL",
                     "LTL",
                     "LVL",
                     "LYD",
                     "MAD",
                     "MDL",
                     "MGA",
                     "MKD",
                     "MMK",
                     "MNT",
                     "MOP",
                     "MRO",
                     "MUR",
                     "MVR",
                     "MWK",
                     "MXN",
                     "MYR",
                     "MZN",
                     "NAD",
                     "NGN",
                     "NIO",
                     "NOK",
                     "NPR",
                     "NZD",
                     "OMR",
                     "PAB",
                     "PEN",
                     "PGK",
                     "PHP",
                     "PKR",
                     "PLN",
                     "PYG",
                     "QAR",
                     "RON",
                     "RSD",
                     "RUB",
                     "RWF",
                     "SAR",
                     "SBD",
                     "SCR",
                     "SDG",
                     "SEK",
                     "SGD",
                     "SHP",
                     "SLL",
                     "SOS",
                     "SRD",
                     "STD",
                     "SVC",
                     "SYP",
                     "SZL",
                     "THB",
                     "TJS",
                     "TMT",
                     "TND",
                     "TOP",
                     "TRY",
                     "TTD",
                     "TWD",
                     "TZS",
                     "UAH",
                     "UGX",
                     "USD",
                     "UYU",
                     "UZS",
                     "VEF",
                     "VND",
                     "VUV",
                     "WST",
                     "XAF",
                     "XAG",
                     "XAU",
                     "XCD",
                     "XDR",
                     "XOF",
                     "XPF",
                     "YER",
                     "ZAR",
                     "ZMK",
                     "ZMW",
                     "ZWL"]

}
