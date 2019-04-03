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
    
    private let endPoint = "https://api.openweathermap.org/data/2.5/forecast"
    lazy var urlEndPoint = URL(string: endPoint)
    let httpMethod = "GET"
    private let keyAPI = "1236"
    var city: String
    var country: String
    lazy var body:String = createBody()
    init(city: String, country: String){
        self.city = city
        self.country = country
    }
    func createBody() -> String {
        let cityModified = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let body = "q=\(cityModified!),\(country)&units=metric&appid=\(keyAPI)"
        return body
    }
    func createFullUrl() -> URL? {
        let endPointUrl = endPoint
        let body = createBody()
        let fullUrl = "\(endPointUrl)?\(body)"
        guard let url = URL(string: fullUrl) else { return nil }
        print(url as Any)
        return url
    }
}

// Struct of weatherResponse
struct WeatherResponse {
    let temp: Double
    let pressure: Double
    let humidity: Double
    let description: String
    let iconString: String
    let windSpeed: Double
    let date: String
    let iconData: Data
}

// Structs of JSON response
struct WeatherConditions: Codable {
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [List]?
    let city: City?
}

struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population: Int?
}

struct Coord: Codable {
    let lat, lon: Double?
}

struct List: Codable {
    let dt: Int?
    let main: MainClass?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let rain: Rain?
    let sys: Sys?
    let dtTxt: String?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, rain, sys
        case dtTxt = "dt_txt"
    }
}

struct Clouds: Codable {
    let all: Int?
}

struct MainClass: Codable {
    let temp, tempMin, tempMax, pressure: Double?
    let seaLevel, grndLevel: Double?
    let humidity: Double?
    let tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct Rain: Codable {
    let the3H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct Sys: Codable {
    let pod: Pod?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

struct Weather: Codable {
    let id: Int?
    let main: MainEnum?
    let description: String?
    let icon: String?
}


enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

struct Wind: Codable {
    let speed, deg: Double?
}
