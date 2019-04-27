//
//  GoogleTranslateAPI.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 27/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import UIKit

class GoogleTranslateAPI {
    let endPoint = "https://translation.googleapis.com/language/translate/v2"
    lazy var urlEndPoint: URL? = createFullUrl()
    let httpMethod = "GET"
    private let keyAPI = valueForAPIKey(named: "APIGoogleTranslateKey")
    var textInput: String
    var targetLanguage: String
    var sourceLanguage: String
    var format = "text"
    lazy var httpBody = createBody()
    var fullURLTranslate: URL? {
        return createFullUrl()
    }
    init(textInput: String, targetLanguage: String, sourceLanguage: String){
        self.textInput = textInput
        self.targetLanguage = targetLanguage
        self.sourceLanguage = sourceLanguage
    }
    private func createBody() -> String {
        // Transform text (string) to be used in URL(String)
        let text = textInput.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let textForSure = text else {
            return ""
        }
        let body = "q=\(textForSure)&target=\(targetLanguage)&format=\(format)&source=\(sourceLanguage)&key=\(keyAPI)"
        return body
    }
    private func createFullUrl() -> URL? {
        let endPointUrl = endPoint
        let body = createBody()
        let fullUrl = "\(endPointUrl)?\(body)"
        guard let url = URL(string: fullUrl) else { return nil }
        print(url as Any)
        return url
    }
}


struct DataClass: Codable {
    let translations: [Translation]?
}

struct Translation: Codable {
    let translatedText: String?
}
