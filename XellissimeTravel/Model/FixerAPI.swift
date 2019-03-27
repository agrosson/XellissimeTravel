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
    static let endPoint = "http://data.fixer.io/api/latest"
    static let urlEndPoint = URL(string: endPoint)
    static let httpMethod = "GET"
    let keyAPI = "123"
    var symbol: String
    lazy var body:String = createBody()
    init(symbol: String){
        self.symbol = symbol
    }
    
    func createBody() -> String {
        let body = "access_key=\(keyAPI)&base=EUR&symbols=\(symbol)"
        return body
    }
}
// var myTargetRequest: URLRequest = createRequest(url: FixerAPI.urlEndPoint!, httpMethod: "post", httpBody: "body")
