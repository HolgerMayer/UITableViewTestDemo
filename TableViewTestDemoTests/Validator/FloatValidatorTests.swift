//
//  FloatValidatorTests.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 13.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest
@testable import TableViewTestDemo

class FloatValidatorTests: XCTestCase {
    
    let testObject = FloatValidator()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNull() {
        XCTAssertTrue(testObject.validate(content:"0"))
        XCTAssertTrue(testObject.validate(content:"00"))
        XCTAssertTrue(testObject.validate(content:"0.0"))
    }
    
    func testMinus() {
        XCTAssertTrue(testObject.validate(content:"-0"))
        XCTAssertTrue(testObject.validate(content:"-1"))
        XCTAssertTrue(testObject.validate(content:"-10.0"))
        XCTAssertTrue(testObject.validate(content:"-10.0E-2"))
    }
    
    func testPositiv() {
        XCTAssertTrue(testObject.validate(content:"1"))
        XCTAssertTrue(testObject.validate(content:"10.0"))
        XCTAssertTrue(testObject.validate(content:"10.0E-2"))
    }
    
    func testE() {
        XCTAssertTrue(testObject.validate(content:"10.0E-2"))
        XCTAssertTrue(testObject.validate(content:"10.0E+2"))
    }
    
    func testWrongFormat() {
        XCTAssertFalse(testObject.validate(content:"PI"))
        XCTAssertFalse(testObject.validate(content:"A1.02"))
        XCTAssertFalse(testObject.validate(content:"10.2032A"))
        XCTAssertFalse(testObject.validate(content:"!dhwu782327"))
        XCTAssertFalse(testObject.validate(content:"23238,238"))
    }
}
