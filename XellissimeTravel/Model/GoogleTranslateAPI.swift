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
    private let endPoint = "https://translation.googleapis.com/language/translate/v2"
    lazy var urlEndPoint = URL(string: endPoint)
    let httpMethod = "GET"
    private let keyAPI = "789"
    var textInput: String
    var targetLanguage: String
    var sourceLanguage: String
    var format = "text"
    lazy var body:String = createBody()
    init(textInput: String, targetLanguage: String, sourceLanguage: String){
        self.textInput = textInput
        self.targetLanguage = targetLanguage
        self.sourceLanguage = sourceLanguage
    }
    func createBody() -> String {
        let body = "q=\(textInput)&target=\(targetLanguage)&format=\(format)&source=\(sourceLanguage)&key=\(keyAPI)"
        return body
    }
}
