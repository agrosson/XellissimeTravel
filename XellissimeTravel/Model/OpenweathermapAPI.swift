//
//  OpenweathermapAPI.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

class OpenweathermapAPI {
    private let endPoint = "api.openweathermap.org/data/2.5/forecast"
    lazy var urlEndPoint = URL(string: endPoint)
    let httpMethod = "GET"
    private let keyAPI = "456"
    var city: String
    var country: String
    lazy var body:String = createBody()
    init(city: String, country: String){
        self.city = city
        self.country = country
    }
    func createBody() -> String {
        let body = "q=\(city),\(country)&appid=\(keyAPI)"
        return body
    }
}
