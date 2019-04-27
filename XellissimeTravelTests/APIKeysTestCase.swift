//
//  APIKeysTestCase.swift
//  XellissimeTravelTests
//
//  Created by ALEXANDRE GROSSON on 27/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import XCTest
@testable import XellissimeTravel

class APIKeysTestCase: XCTestCase {


    // If no return value , then Error
    func testGivenAKeyWhenAccesToKeyThenReturnAString() {
        let key = "222"
        let result: String = valueForAPIKey(named: key)
        XCTAssert(result == "")
    }
}
