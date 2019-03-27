//
//  APIManager.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

/**
 Function that adds a digit when user types a number for the calculation
 - Parameter newNumber: The digit chosen by user on screen
 - Returns: The string to be displayed on screen
 
 # Important Notes #
 0 as first character of the number is not displayed on screen
 */

// MARK: API EndPoint :  variable to switch from one API to another

private var myAPI = FixerAPI(symbol: "usd")

private var myTargetRequest: URLRequest = createRequest(url: myAPI.urlEndPoint!, httpMethod: myAPI.httpMethod, httpBody: myAPI.body)

private func createRequest(url: URL, httpMethod: String, httpBody: String) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    request.httpBody = httpBody.data(using: .utf8)
    return request
}

// MARK: Networking class
class NetworkManager {
    // MARK: Networking properties
    static var shared = NetworkManager()
    private init(){}
    // Task creation
    private var task = URLSessionTask?.self
    
   // #warning("this is for Fixer : changes will be made later on")
    func getChange(callBack : @escaping (Bool,String?) -> ()) {
        let request = myTargetRequest
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
//                guard let responseJson = try? JSONDecoder().decode([FixerAnswer].self, from: data),
//                    
//                    let changeResult? = responseJson[0]
//                    
//                else { callBack(false, nil)
//                    return}
                callBack(true,"result")
            
                }
            }
        
        task.resume()
  
    }
 
    
    // answer for Fixer is type [String : Any]
}

