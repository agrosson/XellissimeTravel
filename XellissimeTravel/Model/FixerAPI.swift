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
    let httpMethod = "GET"
    private let keyAPI = valueForAPIKey(named: "APIFixerKey")
    var symbol: String
    var fixerFullUrl:URL? {
        return createFullUrl()
    }
    init(symbol: String){
        self.symbol = symbol
    }
    
    private func createFullUrl() -> URL? {
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
    static let dB = ["USD",
                     "GBP",
                     "CAD",
                     "AED",
                     "AFN",
                     "ALL",
                     "AMD",
                     "ANG",
                     "AOA",
                     "ARS",
                     "AUD",
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
                     "BTN",
                     "BWP",
                     "BYR",
                     "BZD",
                     "CAD",
                     "CDF",
                     "CHF",
                     "CLP",
                     "CNY",
                     "COP",
                     "CRC",
                     "CUC",
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
                     "INR",
                     "IQD",
                     "IRR",
                     "ISK",
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
                     "MAD",
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
                     "NZD",
                     "PAB",
                     "PEN",
                     "PGK",
                     "PHP",
                     "PKR",
                     "PLN",
                     "PYG",
                     "QAR",
                     "RSD",
                     "RUB",
                     "RWF",
                     "SAR",
                     "SBD",
                     "SCR",
                     "SDG",
                     "SEK",
                     "SGD",
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
                     "ZAR",
                     "ZMW",
                     "ZWL"]

    
    static let currencyCountryCode:[String:[String]] = ["EUR":["EU","EURO"],"USD":["US","DOLLAR"],"AED":["AE","United Arab Emirates Dirham"],"AFN":["AF","Afghan Afghani"],
                                                 "ALL":["AL","Albanian Lek"],
                                                 "AMD":["AM","Armenian Dram"],
                                                 "ANG":["CW","Netherlands Antillean Guilder"],
                                                 "AOA":["AO","Angolan Kwanza"],
                                                 "ARS":["AR","Argentine Peso"],
                                                 "AUD":["AU","Australian Dollar"],
                                                 "AZN":["AZ","Azerbaijani Manat"],
                                                 "BAM":["BA","Bosnia-Herzegovina Convertible Mark"],
                                                 "BBD":["BB","Barbadian Dollar"],
                                                 "BDT":["BD","Bangladeshi Taka"],
                                                 "BGN":["BG","Bulgarian Lev"],
                                                 "BHD":["BH","Bahraini Dinar"],
                                                 "BIF":["BI","Burundian Franc"],
                                                 "BMD":["BM","Bermudan Dollar"],
                                                 "BND":["BN","Brunei Dollar"],
                                                 "BOB":["BO","Bolivian Boliviano"],
                                                 "BRL":["BR","Brazilian Real"],
                                                 "BSD":["BS","Bahamian Dollar"],
                                                 "BTN":["BT","Bhutanese Ngultrum"],
                                                 "BWP":["BW","Botswanan Pula"],
                                                 "BYR":["BY","Belarusian Ruble"],
                                                 "BZD":["BZ","Belize Dollar"],
                                                 "CAD":["CA","Canadian Dollar"],
                                                 "CDF":["CD","Congolese Franc"],
                                                 "CHF":["CH","Swiss Franc"],
                                                 "CLP":["CL","Chilean Peso"],
                                                 "CNY":["CN","Chinese Yuan"],
                                                 "COP":["CO","Colombian Peso"],
                                                 "CRC":["CR","Costa Rican Colón"],
                                                 "CUC":["CU","Cuban Convertible Peso"],
                                                 "CVE":["CV","Cape Verdean Escudo"],
                                                 "CZK":["CZ","Czech Republic Koruna"],
                                                 "DJF":["DJ","Djiboutian Franc"],
                                                 "DKK":["DK","Danish Krone"],
                                                 "DOP":["DO","Dominican Peso"],
                                                 "DZD":["DZ","Algerian Dinar"],
                                                 "EGP":["EG","Egyptian Pound"],
                                                 "ERN":["ER","Eritrean Nakfa"],
                                                 "ETB":["ET","Ethiopian Birr"],
                                                 "FJD":["FJ","Fijian Dollar"],
                                                 "FKP":["FK","Falkland Islands Pound"],
                                                 "GBP":["GB","British Pound Sterling"],
                                                 "GEL":["GE","Georgian Lari"],
                                                 "GIP":["GI","Gibraltar Pound"],
                                                 "GMD":["GM","Gambian Dalasi"],
                                                 "GNF":["GN","Guinean Franc"],
                                                 "GTQ":["GT","Guatemalan Quetzal"],
                                                 "GYD":["GY","Guyanaese Dollar"],
                                                 "HKD":["HK","Hong Kong Dollar"],
                                                 "HNL":["HN","Honduran Lempira"],
                                                 "HRK":["HR","Croatian Kuna"],
                                                 "HTG":["HT","Haitian Gourde"],
                                                 "HUF":["HU","Hungarian Forint"],
                                                 "IDR":["ID","Indonesian Rupiah"],
                                                 "ILS":["IL","Israeli New Sheqel"],
                                                 "INR":["IN","Indian Rupee"],
                                                 "IQD":["IQ","Iraqi Dinar"],
                                                 "IRR":["IR","Iranian Rial"],
                                                 "ISK":["IS","Icelandic Króna"],
                                                 "JMD":["JM","Jamaican Dollar"],
                                                 "JOD":["JO","Jordanian Dinar"],
                                                 "JPY":["JP","Japanese Yen"],
                                                 "KES":["KE","Kenyan Shilling"],
                                                 "KGS":["KG","Kyrgystani Som"],
                                                 "KHR":["KH","Cambodian Riel"],
                                                 "KMF":["KM","Comorian Franc"],
                                                 "KPW":["KP","North Korean Won"],
                                                 "KRW":["KR","South Korean Won"],
                                                 "KWD":["KW","Kuwaiti Dinar"],
                                                 "KYD":["KY","Cayman Islands Dollar"],
                                                 "KZT":["KZ","Kazakhstani Tenge"],
                                                 "LAK":["LA","Laotian Kip"],
                                                 "LBP":["LB","Lebanese Pound"],
                                                 "LKR":["LK","Sri Lankan Rupee"],
                                                 "LRD":["LR","Liberian Dollar"],
                                                 "LSL":["LS","Lesotho Loti"],
                                                 "MAD":["MA","Moroccan Dirham"],
                                                 "MNT":["MN","Mongolian Tugrik"],
                                                 "MOP":["MO","Macanese Pataca"],
                                                 "MRO":["MR","Mauritanian Ouguiya"],
                                                 "MUR":["MU","Mauritian Rupee"],
                                                 "MVR":["MV","Maldivian Rufiyaa"],
                                                 "MWK":["MW","Malawian Kwacha"],
                                                 "MXN":["MX","Mexican Peso"],
                                                 "MYR":["MY","Malaysian Ringgit"],
                                                 "MZN":["MZ","Mozambican Metical"],
                                                 "NAD":["NA","Namibian Dollar"],
                                                 "NGN":["NG","Nigerian Naira"],
                                                 "NIO":["NI","Nicaraguan Córdoba"],
                                                 "NOK":["NO","Norwegian Krone"],
                                                 "NZD":["NZ","New Zealand Dollar"],
                                                 "PAB":["PA","Panamanian Balboa"],
                                                 "PEN":["PE","Peruvian Nuevo Sol"],
                                                 "PGK":["PG","Papua New Guinean Kina"],
                                                 "PHP":["PH","Philippine Peso"],
                                                 "PKR":["PK","Pakistani Rupee"],
                                                 "PLN":["PL","Polish Zloty"],
                                                 "PYG":["PY","Paraguayan Guarani"],
                                                 "QAR":["QA","Qatari Rial"],
                                                 "RSD":["RS","Serbian Dinar"],
                                                 "RUB":["RU","Russian Ruble"],
                                                 "RWF":["RW","Rwandan Franc"],
                                                 "SAR":["SA","Saudi Riyal"],
                                                 "SBD":["SB","Solomon Islands Dollar"],
                                                 "SCR":["SC","Seychellois Rupee"],
                                                 "SDG":["SD","Sudanese Pound"],
                                                 "SEK":["SE","Swedish Krona"],
                                                 "SGD":["SG","Singapore Dollar"],
                                                 "SLL":["SL","Sierra Leonean Leone"],
                                                 "SOS":["SO","Somali Shilling"],
                                                 "SRD":["SR","Surinamese Dollar"],
                                                 "STD":["SS","São Tomé and Príncipe Dobra"],
                                                 "SVC":["SV","Salvadoran Colón"],
                                                 "SYP":["SY","Syrian Pound"],
                                                 "SZL":["SZ","Swazi Lilangeni"],
                                                 "THB":["TH","Thai Baht"],
                                                 "TJS":["TJ","Tajikistani Somoni"],
                                                 "TMT":["TM","Turkmenistani Manat"],
                                                 "TND":["TN","Tunisian Dinar"],
                                                 "TOP":["TO","Tongan Paʻanga"],
                                                 "TRY":["TR","Turkish Lira"],
                                                 "TTD":["TT","Trinidad and Tobago Dollar"],
                                                 "TWD":["TW","New Taiwan Dollar"],
                                                 "TZS":["TZ","Tanzanian Shilling"],
                                                 "UAH":["UA","Ukrainian Hryvnia"],
                                                 "UGX":["UG","Ugandan Shilling"],
                                                 "UYU":["UY","Uruguayan Peso"],
                                                 "UZS":["UZ","Uzbekistan Som"],
                                                 "VEF":["VE","Venezuelan Bolívar Fuerte"],
                                                 "VND":["VN","Vietnamese Dong"],
                                                 "VUV":["VU","Vanuatu Vatu"],
                                                 "WST":["WS","Samoan Tala"],
                                                 "ZAR":["ZA","South African Rand"],
                                                 "ZMW":["ZM","Zambian Kwacha"],
                                                 "ZWL":["ZW","Zimbabwean Dollar"]]
}

