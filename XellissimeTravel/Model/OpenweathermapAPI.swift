//
//  OpenweathermapAPI.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Class OpenweathermapAPI
/**
 This class enables to set parameters of the API Openweathermap
 */
class OpenweathermapAPI {
    // MARK: - Properties
    /// API endPoint string
    private let endPoint = "https://api.openweathermap.org/data/2.5/forecast"
    /// API endPoint URL
    var urlEndPoint:URL? {
        return URL(string: endPoint)
    }
    /// API method
    let httpMethod = "GET"
    /// API Key
    private let keyAPI = valueForAPIKey(named: "APIOpenWeatherMapKey")
    /// API parameters : city
    var city: String
    /// API parameters : country
    var country: String
    /// API parameters : Body
    lazy var body:String = createBody()
    /// API parameters : FullURL
    var fullURLWeather: URL? {
        return createFullUrl()
    }
    // MARK: -
    init(city: String, country: String){
        self.city = city
        self.country = country
    }
    
    // MARK: - Methods
    /**
     Function that creates the body as a String
     - Returns: Body as a String
     */
    private func createBody() -> String {
        let cityModified = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let cityModifiedForSure = cityModified else {
            return ""
        }
        let body = "q=\(cityModifiedForSure),\(country)&units=metric&appid=\(keyAPI)"
        return body
    }
    /**
     Function that creates the full URL
     - Returns: Full URL
     */
    private func createFullUrl() -> URL? {
        let endPointUrl = endPoint
        let body = createBody()
        let fullUrl = "\(endPointUrl)?\(body)"
        guard let url = URL(string: fullUrl) else { return nil }
        print(url as Any)
        return url
    }
}
// MARK: - Struct for weatherResponse
/// Struct of weatherResponse : this structure retrieves all elements needed for viewController from global JSON reponse file which has been got with the request
struct WeatherResponse {
    /// Current temperature
    let temp: Double
    /// Daily min temperature
    let tempMin: Double
    /// Daily max temperature
    let tempMax: Double
    /// Current pressure
    let pressure: Double
    /// Current humidity
    let humidity: Double
    /// Name of icon
    let iconString: String
    /// Current wind speed
    let windSpeed: Double
    /// Current date
    let date: String
    
    init?(temp: Double?, tempMin: Double?, tempMax: Double?, pressure: Double?, humidity: Double?, iconString: String?, windSpeed : Double?, date : String?) {
        if let temp = temp, let tempMax = tempMax, let tempMin = tempMin, let pressure = pressure, let humidity = humidity, let iconString = iconString, let windSpeed = windSpeed, let date = date {
            self.temp = temp
            self.tempMin = tempMin
            self.tempMax = tempMax
            self.pressure = pressure
            self.humidity = humidity
            self.iconString = iconString
            self.windSpeed = windSpeed
            self.date = date
        } else {
            return nil
        }
    }
}
// MARK: - Structs from JSON response file :
// Structs of JSON response file : global struct
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
