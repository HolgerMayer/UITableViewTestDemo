//
//  ModelTests.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 09.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest
@testable import TableViewTestDemo

class ModelTests: XCTestCase {
    
    var testObject : Model!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.testObject = Model()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialize() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(testObject.data.count == 3)
        XCTAssertTrue(testObject.apples()?.count == 1)
        XCTAssertTrue(testObject.berrys()?.count == 2)
        XCTAssertTrue(testObject.cherries()?.count == 0)
    }
    
    func testFirstName() {
        let name = self.testObject.generateDefaultNameFor(category: .cherry)
        XCTAssertTrue(name == FruitCategory.cherry.rawValue + " 0")
    }
    
    func testSecondName() {
        
        let fruit = Fruit(name:  self.testObject.generateDefaultNameFor(category: .cherry), category: .cherry)
        self.testObject.data.append(fruit)
        let name = self.testObject.generateDefaultNameFor(category: .cherry)
        XCTAssertTrue(name == FruitCategory.cherry.rawValue + " 1")

    }
    
    func testThirdName() {
        let fruit = Fruit(name:  self.testObject.generateDefaultNameFor(category: .cherry), category: .cherry)
        self.testObject.data.append(fruit)
        let fruit0 = Fruit(name:  self.testObject.generateDefaultNameFor(category: .cherry), category: .cherry)
        self.testObject.data.append(fruit0)
        let name = self.testObject.generateDefaultNameFor(category: .cherry)
        XCTAssertTrue(name == FruitCategory.cherry.rawValue + " 2")

    }
    
    func testFillSecondName(){
        let fruit = Fruit(name:  self.testObject.generateDefaultNameFor(category: .cherry), category: .cherry)
        self.testObject.data.append(fruit)
        let fruit0 = Fruit(name:  self.testObject.generateDefaultNameFor(category: .cherry), category: .cherry)
        self.testObject.data.append(fruit0)
        let fruit1 = Fruit(name:  self.testObject.generateDefaultNameFor(category: .cherry), category: .cherry)
        self.testObject.data.append(fruit1)
        fruit0.name = "Hugo"
        let name = self.testObject.generateDefaultNameFor(category: .cherry)
        XCTAssertTrue(name == FruitCategory.cherry.rawValue + " 1","Name is \(name)")

    }
 
    
}
