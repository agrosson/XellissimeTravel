//
//  GoogleTranslateAPI.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Class GoogleTranslateAPI
/**
 This class enables to set parameters of the API fixer.io
 */
class GoogleTranslateAPI {
    // MARK: - Properties
    /// API endPoint string
    let endPoint = "https://translation.googleapis.com/language/translate/v2"
    /// API endPoint URL
    var urlEndPoint: URL? {
        return createFullUrl()
    }
    /// Api Method
    let httpMethod = "GET"
    /// API Key
    private let keyAPI = valueForAPIKey(named: "APIGoogleTranslateKey")
    /// API parameters : text to translate
    var textInput: String
    /// API parameters : language targeted
    var targetLanguage: String
    /// API parameters : language source
    var sourceLanguage: String
    /// API parameters : text format
    var format = "text"
    /// API parameters : Body
    lazy var httpBody = createBody()
    /// API parameters : FullURL
    var fullURLTranslate: URL? {
        return createFullUrl()
    }
    // MARK: -
    init(textInput: String, targetLanguage: String, sourceLanguage: String){
        self.textInput = textInput
        self.targetLanguage = targetLanguage
        self.sourceLanguage = sourceLanguage
    }
    // MARK: - Methods
    /**
     Function that creates the body as a String
     - Returns: Body as a String
     */
    private func createBody() -> String {
        // Transform text (string) to be used in URL(String)
        let text = textInput.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let textForSure = text else {
            return ""
        }
        let body = "q=\(textForSure)&target=\(targetLanguage)&format=\(format)&source=\(sourceLanguage)&key=\(keyAPI)"
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

// MARK: - Structs from JSON response file :
// Structs of JSON response file : global struct
struct DataClass: Codable {
    let translations: [Translation]?
}

struct Translation: Codable {
    let translatedText: String?
}
