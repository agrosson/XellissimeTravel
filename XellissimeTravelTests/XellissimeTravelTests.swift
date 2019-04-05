//
//  XellissimeTravelTests.swift
//  XellissimeTravelTests
//
//  Created by ALEXANDRE GROSSON on 26/03/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import XCTest
@testable import XellissimeTravel

class XellissimeTravelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // Test to check if all currencies have a country code
    func testGivenAllCurrency_WhenTestIfThereIsACountryCode_ThenNoNil() {
        var counter = 0
        for item in CurrencyDataBase.dB{
            if CurrencyDataBase.currencyCountryCode[item] == nil {
                counter += 1
            }
        }
        XCTAssert(counter==0)
    }
    // Test to check if all currencies have a country flag
    func testGivenAllCurrency_WhenTestIfThereIsAFlag_ThenNoNil() {
        var counter = 0
        for item in CurrencyDataBase.dB{
            let flagId = CurrencyDataBase.currencyCountryCode[item]![0]
            let imageTest =  UIImage(named: flagId)
            if imageTest == nil {
                counter += 1
            }
            }
        XCTAssert(counter==0)
    }
    
    func testExample() {
      
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
