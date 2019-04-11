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
    // MARK: Networking properties
    static var shared = NetworkManager()
    private init() {}
    // Task creation
    private var task: URLSessionDataTask?
    
    let changeSession = URLSession(configuration: .default)
    let translateSession = URLSession(configuration: .default)
    let weatherSession = URLSession(configuration: .default)
}

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
                let translation = translationResultData.translations![0].translatedText
                callBack(true, translation)
            }
        }
        task.resume()
    }
}
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
                    let weatherResponse = WeatherResponse(temp: (responseJson.list![iDay].main?.temp)!,
                                                          tempMin: (responseJson.list![iDay].main?.tempMin)!,
                                                          tempMax: (responseJson.list![iDay].main?.tempMax)!,
                                                          pressure: (responseJson.list![iDay].main?.pressure)!,
                                                          humidity: (responseJson.list![iDay].main?.humidity)!,
                                                          description: (responseJson.list![iDay].weather![0].description)!,
                                                          iconString: (responseJson.list![iDay].weather![0].icon)!,
                                                          windSpeed: (responseJson.list![iDay].wind?.speed)!,
                                                          date: (responseJson.list![iDay].dtTxt)!
                    )
                    testArrayResponse.append(weatherResponse)
                }
                callBack(true, testArrayResponse)
            }
        }
        task.resume()
    }
}
extension NetworkManager {
    func getImage(pictureURL: URL, completionHandler: @escaping (Data?) -> Void) {
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: pictureURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(nil)
                    return
                }
                completionHandler(data)
            }
        }
        task?.resume()
    }
}
