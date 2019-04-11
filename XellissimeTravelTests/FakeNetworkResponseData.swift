//
//  FakeNetworkResponseData.swift
//  XellissimeTravelTests
//
//  Created by ALEXANDRE GROSSON on 11/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation

class FakeNetworkResponseData {
    // instance of response OK - statusCode 200
    static let responseOK = HTTPURLResponse(url: URL(string: "uneURL")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    // instance of response KO - statusCode not 200
    static let responseKO = HTTPURLResponse(url: URL(string: "uneURL")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    // Creation of an error
    class NetworkError: Error {}
    static let error = NetworkError()
    // Retrieve correct datas to test for each API
    static var weatherCorrectData: Data? {
        // retrieve bundle where FakeWeatherResponseData is
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        // retrieve url of file to test
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var changeCorrectData: Data? {
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        let url = bundle.url(forResource: "Change", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    // Creation of an incorrect datas
    let weatherIncorrectData = "It's a weather error".data(using: .utf8)!
    let translateIncorrectData = "It's a translate error".data(using: .utf8)!
    let fxIncorrectData = "It's a FX error".data(using: .utf8)!
}
