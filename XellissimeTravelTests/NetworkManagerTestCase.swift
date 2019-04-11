//
//  NetworkManagerTestCase.swift
//  XellissimeTravelTests
//
//  Created by ALEXANDRE GROSSON on 11/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import XCTest
@testable import XellissimeTravel


class NetworkManagerTestCase: XCTestCase {

    
    // Block for testing translate
    func testTranslateShouldPostFailedCallbackIfError() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            translateSession: URLSessionFake(data: nil, response: nil, error: FakeNetworkResponseData.error),
                                            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        networkManager.translate(fullUrl: URL(string: "nil")!, method: "nil", body: "nil", callBack: { (success, text) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(text)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    

    
    func testTranslateShouldPostFailedCallbackIfnoData() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            translateSession: URLSessionFake(data: nil, response: FakeNetworkResponseData.responseOK, error: nil ),
                                            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        networkManager.translate(fullUrl: URL(string: "nil")!, method: "nil", body: "nil", callBack: { (success, text) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(text)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostFailedCallbackIfResponseKO() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            translateSession: URLSessionFake(data: FakeNetworkResponseData.translateCorrectData, response: FakeNetworkResponseData.responseKO, error: nil ),
                                            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        networkManager.translate(fullUrl: URL(string: "nil")!, method: "nil", body: "nil", callBack: { (success, text) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(text)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostFailedCallbackIfResponseOKNoErrorDataIncorrect() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            translateSession: URLSessionFake(data: FakeNetworkResponseData.translateIncorrectData, response: FakeNetworkResponseData.responseOK, error: nil ),
                                            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        networkManager.translate(fullUrl: URL(string: "nil")!, method: "nil", body: "nil", callBack: { (success, text) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(text)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPassCallbackIfCorrectDataAndNoError() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            translateSession: URLSessionFake(data: FakeNetworkResponseData.translateCorrectData, response: FakeNetworkResponseData.responseOK, error: nil),
                                            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        networkManager.translate(fullUrl: URL(string: "nil")!, method: "nil", body: "nil", callBack: { (success, text) in
            // Then
            let textToCheck = "I believe that victory is near"
            XCTAssertTrue(success)
            XCTAssertEqual(text!, textToCheck)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Code for testing Change
    func testChangeShouldPostFailedCallbackIfError() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: FakeNetworkResponseData.error),
                                            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        networkManager.getChange(fullUrl: URL(string: "nill")!, method: "nill", ToCurrency: "USD", callBack: { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        })
            wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeShouldPostFailedCallbackIfNoData() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        networkManager.getChange(fullUrl: URL(string: "nill")!, method: "nill", ToCurrency: "USD", callBack: { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeShouldPostFailedCallbackIfResponseKO() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: FakeNetworkResponseData.changeCorrectData, response: FakeNetworkResponseData.responseKO, error: nil),
                                            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        networkManager.getChange(fullUrl: URL(string: "nill")!, method: "nill", ToCurrency: "USD", callBack: { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testChangeShouldPostFailedCallbackIfResponseOKButIncorrectData() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: FakeNetworkResponseData.fxIncorrectData, response: FakeNetworkResponseData.responseOK, error: nil),
                                            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        networkManager.getChange(fullUrl: URL(string: "nill")!, method: "nill", ToCurrency: "USD", callBack: { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testChangeShouldPostPassCallbackIfResponseOKNoErrorAndCorrectData() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: FakeNetworkResponseData.changeCorrectData, response: FakeNetworkResponseData.responseOK, error: nil),
                                            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let rateToGet:Float = 1.127942
        networkManager.getChange(fullUrl: URL(string: "nill")!, method: "nill", ToCurrency: "USD", callBack: { (success, rate) in
            // Then
            XCTAssertTrue(success)
            XCTAssertEqual(rate, rateToGet)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Code for testing Weather
    func testWeatherShouldPostFailedCallbackIfError() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: nil ),
                                            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeNetworkResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        var allDays: [Int] {
            var array = [Int]()
            for item in 0...39{
                array.append(item)
            }
            return array
        }
        networkManager.getWeather(fullUrl: URL(string: "nill")!, method: "nill", body: "nill", dayArray: allDays, callBack:  { (success, weatherResponse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResponse)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostFailedCallbackIfNodata() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: nil ),
                                            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        var allDays: [Int] {
            var array = [Int]()
            for item in 0...39{
                array.append(item)
            }
            return array
        }
        networkManager.getWeather(fullUrl: URL(string: "nill")!, method: "nill", body: "nill", dayArray: allDays, callBack:  { (success, weatherResponse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResponse)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostFailedCallbackIfResponseKO() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: nil ),
                                            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            weatherSession: URLSessionFake(data: FakeNetworkResponseData.weatherCorrectData, response: FakeNetworkResponseData.responseKO, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        var allDays: [Int] {
            var array = [Int]()
            for item in 0...39{
                array.append(item)
            }
            return array
        }
        networkManager.getWeather(fullUrl: URL(string: "nill")!, method: "nill", body: "nill", dayArray: allDays, callBack:  { (success, weatherResponse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResponse)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    func testWeatherShouldPostFailedCallbackIfResponseOKbutNoData() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: nil ),
                                            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            weatherSession: URLSessionFake(data: nil, response: FakeNetworkResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        var allDays: [Int] {
            var array = [Int]()
            for item in 0...39{
                array.append(item)
            }
            return array
        }
        networkManager.getWeather(fullUrl: URL(string: "nill")!, method: "nill", body: "nill", dayArray: allDays, callBack:  { (success, weatherResponse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResponse)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostFailedCallbackIfResponseOKbutIncorrectData() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: nil ),
                                            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            weatherSession: URLSessionFake(data: FakeNetworkResponseData.weatherIncorrectData, response: FakeNetworkResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        var allDays: [Int] {
            var array = [Int]()
            for item in 0...39{
                array.append(item)
            }
            return array
        }
        networkManager.getWeather(fullUrl: URL(string: "nill")!, method: "nill", body: "nill", dayArray: allDays, callBack:  { (success, weatherResponse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResponse)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostPassCallbackIfResponseOKNoErrorAndCorrectData() {
        // Given
        let networkManager = NetworkManager(changeSession: URLSessionFake(data: nil, response: nil, error: nil ),
                                            translateSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            weatherSession: URLSessionFake(data: FakeNetworkResponseData.weatherCorrectData, response: FakeNetworkResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        var allDays: [Int] {
            var array = [Int]()
            for item in 0...39{
                array.append(item)
            }
            return array
        }
        networkManager.getWeather(fullUrl: URL(string: "nill")!, method: "nill", body: "nill", dayArray: allDays, callBack:  { (success, weatherResponse) in
            // Then
            XCTAssertTrue(success)
            XCTAssertEqual(allDays.count, weatherResponse?.count)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
}
