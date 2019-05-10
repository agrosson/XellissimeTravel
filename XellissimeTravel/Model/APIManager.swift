//
//  APIManager.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

// MARK: Networking class
class NetworkManager {
    // MARK: Singleton
    static var shared = NetworkManager()
    private init() {}
    // Task creation
    // MARK: - Networking properties
    private var task: URLSessionDataTask?
    private var changeSession = URLSession(configuration: .default)
    private var translateSession = URLSession(configuration: .default)
    private var weatherSession = URLSession(configuration: .default)
    // MARK: -
    init(changeSession: URLSession, translateSession: URLSession, weatherSession: URLSession){
        self.changeSession = changeSession
        self.translateSession = translateSession
        self.weatherSession = weatherSession
    }
}
// MARK: - Request for FX
extension NetworkManager {
    func getChange(fullUrl: URL, method: String, ToCurrency: String, callBack: @escaping (Bool, Float?) -> ()) {
        var request = URLRequest(url: fullUrl)
        request.httpMethod = method
        task?.cancel()
        let task = changeSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil)
                    return
                }
                guard let responseJson = try? JSONDecoder().decode(ExchangeAnswer.self, from: data),
                    let changeResult = responseJson.rates
                    else {
                        callBack(false, nil)
                        return
                }
                let test = changeResult[ToCurrency]
                callBack(true, test)
            }
        }
        task.resume()
    }
}
// MARK: - Request for Translation
extension NetworkManager {
    func translate(fullUrl: URL, method: String, body: String, callBack: @escaping (Bool, String?) -> ()) {
        var request = URLRequest(url: fullUrl)
        print(fullUrl)
        request.httpMethod = method
        print(body)
        task?.cancel()
        let task = translateSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print(error as Any)
                    callBack(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false, nil)
                    return
                }
                guard let responseJson = try? JSONDecoder().decode([String:DataClass].self, from: data),
                    let translationResultData = responseJson["data"]
                    else {
                        callBack(false, nil)
                        return
                }
                
                guard let translation = translationResultData.translations else {
                    callBack(false, nil)
                    return
                }
                
                if translation.count > 0 {
                    callBack(true, translation[0].translatedText)
                } else {
                    callBack(false, nil)
                    return
                }
            }
        }
        task.resume()
    }
}
// MARK: - Request for weather
extension NetworkManager {
    func getWeather(fullUrl : URL,method : String,body: String, dayArray: [Int], callBack : @escaping (Bool,[WeatherResponse]?) -> ()) {
        var request = URLRequest(url: fullUrl)
        request.httpMethod = method
        task?.cancel()
        let task = weatherSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print(error as Any)
                    callBack(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false,nil)
                    return
                }
                guard let responseJson = try? JSONDecoder().decode(WeatherConditions.self, from: data)
                    else {
                        callBack(false, nil)
                        return
                }
                var testArrayResponse = [WeatherResponse]()
                for  iDay in dayArray {
                    guard let list = responseJson.list else {
                        callBack(false, nil)
                        return
                    }
                    guard list.count > iDay else {
                        callBack(false, nil)
                        return
                    }
                    guard let main = list[iDay].main else {
                        callBack(false, nil)
                        return
                    }
                    guard let weather = list[iDay].weather else {
                        callBack(false, nil)
                        return
                    }
                    guard !weather.isEmpty else {
                        callBack(false, nil)
                        return
                    }
                    guard let wind = list[iDay].wind else {
                        callBack(false, nil)
                        return
                    }
                    let weatherResponse = WeatherResponse(temp: main.temp,
                                                          tempMin: main.tempMin,
                                                          tempMax: main.tempMax,
                                                          pressure: main.pressure,
                                                          humidity: main.humidity,
                                                          iconString: weather[0].icon,
                                                          windSpeed: wind.speed,
                                                          date: list[iDay].dtTxt)
                    guard let finalWeatherResponse = weatherResponse else {
                        callBack(false, nil)
                        return
                    }
                     testArrayResponse.append(finalWeatherResponse)
                }
                callBack(true, testArrayResponse)
            }
        }
        task.resume()
    }
}
