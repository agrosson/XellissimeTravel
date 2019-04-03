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
    
    // api.openweathermap.org/data/2.5/forecast?q=New York,US&lang=en&appid=909206e8337bc2fce588605a50cb499f&units=metric
    private let endPoint = "https://api.openweathermap.org/data/2.5/forecast"
    lazy var urlEndPoint = URL(string: endPoint)
    let httpMethod = "GET"
    private let keyAPI = "1234"
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

struct WeatherResponse {
    let temp: Double
    let pressure: Double
    let humidity: Double
    let description: String
    let iconString: String
    let windSpeed: Double
    let date: String
}
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

/*
 Parameters:
 
 coord
 coord.lon City geo location, longitude
 coord.lat City geo location, latitude
 weather (more info Weather condition codes)
 weather.id Weather condition id
 weather.main Group of weather parameters (Rain, Snow, Extreme etc.)
 weather.description Weather condition within the group
 weather.icon Weather icon id
 base Internal parameter
 main
 main.temp Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
 main.pressure Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
 main.humidity Humidity, %
 main.temp_min Minimum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
 main.temp_max Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
 main.sea_level Atmospheric pressure on the sea level, hPa
 main.grnd_level Atmospheric pressure on the ground level, hPa
 wind
 wind.speed Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
 wind.deg Wind direction, degrees (meteorological)
 clouds
 clouds.all Cloudiness, %
 rain
 rain.1h Rain volume for the last 1 hour, mm
 rain.3h Rain volume for the last 3 hours, mm
 snow
 snow.1h Snow volume for the last 1 hour, mm
 snow.3h Snow volume for the last 3 hours, mm
 dt Time of data calculation, unix, UTC
 sys
 sys.type Internal parameter
 sys.id Internal parameter
 sys.message Internal parameter
 sys.country Country code (GB, JP etc.)
 sys.sunrise Sunrise time, unix, UTC
 sys.sunset Sunset time, unix, UTC
 id City ID
 name City name
 cod Internal parameter
 */
