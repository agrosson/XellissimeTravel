//
//  APIManager.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

// MARK: API EndPoint :  variable to switch from one API to another


// MARK: Networking class
class NetworkManager {
    // MARK: Networking properties
    static var shared = NetworkManager()
    private init(){}
    // Task creation
    private var task = URLSessionTask?.self
}

extension NetworkManager {
    func getChange(fullUrl : URL,method : String,ToCurrency: String, callBack : @escaping (Bool,Float?) -> ()) {
        var request = URLRequest(url: fullUrl)
        request.httpMethod = method
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callBack(false,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false,nil)
                    return
                }
                guard let responseJson = try? JSONDecoder().decode(ExchangeAnswer.self, from: data),
                    let changeResult = responseJson.rates
                    else {
                        callBack(false, nil)
                        return
                }
                let test = changeResult[ToCurrency]
                callBack(true,test)
            }
        }
        task.resume()
    }
}

extension NetworkManager {
    
    func translate(fullUrl : URL,method : String,body: String, callBack : @escaping (Bool,String?) -> ()) {
        var request = URLRequest(url: fullUrl)
        print(fullUrl)
        request.httpMethod = method
       // request.httpMethod = body
        print(body)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("l'erreur ici")
                    print(error as Any)
                    callBack(false,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callBack(false,nil)
                    return
                }
                print("so far 1")
                guard let responseJson = try? JSONDecoder().decode([String:DataClass].self, from: data),
                    let translationResultData = responseJson["data"]
                    else {
                        callBack(false, nil)
                        return
                }
                
                print("so far 2")
                let translation = translationResultData.translations![0].translatedText
                print(translation as Any)
                callBack(true,translation)
            }
        }
        task.resume()
    }
}
