//
//  StringExtensionTestCase.swift
//  XellissimeTravelTests
//
//  Created by ALEXANDRE GROSSON on 27/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import XCTest
@testable import XellissimeTravel

class StringExtensionTestCase: XCTestCase {

    // test removeFirstAndLastAndDoubleWhitespace() success
    func testGivenAStringWhenWhiteSpaceThenRemoveIt() {
    var testString = "  a  string  "
    let cleanString = "a string"
    testString.removeFirstAndLastAndDoubleWhitespace()
    XCTAssert(cleanString == testString)
    }
    //
    func testGivenAStringWhenWhiteSpaceThenRemoveItWithError() {
        var testString = "  a  string  "
        let cleanString = "a  string"
        testString.removeFirstAndLastAndDoubleWhitespace()
        XCTAssert(cleanString != testString)
    }

}
