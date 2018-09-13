//
//  UniqueStringValidatorTests.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 13.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest
@testable import TableViewTestDemo

class UniqueStringValidatorTests: XCTestCase {
    
    var testObject : UniqueStringValidator!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testObject = UniqueStringValidator()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testNoPreviousEntries() {
        XCTAssertTrue(testObject.validate(content:"PI"))
    }
    
    func testPreviousEntries() {
        
        let existingNames = ["Hugo","Bernd","Briegel"]
        testObject.existingStrings = existingNames
        
        
        XCTAssertTrue(testObject.validate(content:"PI"))
        XCTAssertFalse(testObject.validate(content:"Briegel"))
        XCTAssertTrue(testObject.validate(content:"Briegel 1"))
   }
}
