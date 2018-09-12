//
//  EditableFruitTableViewCellTests.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 12.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest
@testable import TableViewTestDemo

class EditableFruitTableViewCellTests: XCTestCase {
    
    var testObject : EditableFruitTableViewCell!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: DemoTableViewController.self)
        let storyboard = UIStoryboard(name:"Main", bundle:bundle)
        let controller = storyboard.instantiateViewController(withIdentifier: "DemoTableViewControllerID") as? DemoTableViewController
        let mockAdapter = ObjectAdapterMock()
        controller?.dataSource = mockAdapter
        controller?.loadViewIfNeeded()
        
        let cell = controller?.tableView?.dequeueReusableCell(withIdentifier: "EditableFruitTableViewCellID")
        XCTAssertNotNil(cell)
        guard let fruitCell = cell as? EditableFruitTableViewCell else {
            XCTAssertTrue(false)
            return
        }
        
        self.testObject = fruitCell
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTitleFieldNotNil() {
        XCTAssertNotNil(testObject.titleField)
    }
    
    func testPriceFieldNotNil() {
        XCTAssertNotNil(testObject.priceField)
    }
    
    func testSetContentToNil() {
        testObject.content = nil
        XCTAssertNil(testObject.content)
        XCTAssertTrue(testObject.titleField?.text == "")
        XCTAssertTrue(testObject.priceField?.text == "")
    }
    
    func testSetContentToWrongObjectClass() {
        testObject.content = Date()
        XCTAssertNotNil(testObject.content)
        XCTAssertTrue(testObject.titleField?.text == "Wrong object class")
        XCTAssertTrue(testObject.priceField?.text == "")
    }
    
    func testSetContentToFruit() {
        testObject.content = Fruit(name: "Strawberry", category: .berry, price: 22.0)
        XCTAssertNotNil(testObject.content)
        XCTAssertTrue(testObject.titleField?.text == "Strawberry", "textLabel should be : Strawberry - is \((testObject.titleField?.text)!)")
        XCTAssertTrue(testObject.priceField?.text == "\(22.0)", "textLabel should be : 22.0 - is \((testObject.priceField?.text)!)")
    }
}
