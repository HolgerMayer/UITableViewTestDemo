//
//  FruitTests.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 09.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest
@testable import TableViewTestDemo

class FruitTests: XCTestCase {
    
    var testObject : Fruit!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithName() {
        
        self.testObject = Fruit(name: "Strawberry")
        
        XCTAssertTrue(self.testObject.name == "Strawberry")
        XCTAssertTrue(self.testObject.category == .berry)
        XCTAssertTrue(self.testObject.price == 10.0)
        
    }
    
    func testInitWithCategory() {
        
        self.testObject = Fruit(name: "Golden Delicious",category:.apple)
        
        XCTAssertTrue(self.testObject.name == "Golden Delicious")
        XCTAssertTrue(self.testObject.category == .apple)
        XCTAssertTrue(self.testObject.price == 10.0)
        
    }
  
    func testInitWithCategoryAndPrice() {
        
        self.testObject = Fruit(name: "Sunburst",category:.cherry, price : 13.50)
        
        XCTAssertTrue(self.testObject.name == "Sunburst")
        XCTAssertTrue(self.testObject.category == .cherry)
        XCTAssertTrue(self.testObject.price == 13.50)
        
    }
    
}
