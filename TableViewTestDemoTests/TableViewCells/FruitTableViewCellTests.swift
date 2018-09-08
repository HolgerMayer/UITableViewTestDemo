//
//  FruitTableViewCellTests.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 09.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest
@testable import TableViewTestDemo

class FruitTableViewCellTests: XCTestCase {
    
    var testObject : FruitTableViewCell!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: DemoTableViewController.self)
        let storyboard = UIStoryboard(name:"Main", bundle:bundle)
        let controller = storyboard.instantiateViewController(withIdentifier: "DemoTableViewControllerID") as? DemoTableViewController
        let mockAdapter = ObjectAdapterMock()
        controller?.dataSource = mockAdapter
        controller?.loadViewIfNeeded()
        
        let cell = controller?.tableView?.dequeueReusableCell(withIdentifier: "FruitTableViewCellID")
        XCTAssertNotNil(cell)
        guard let fruitCell = cell as? FruitTableViewCell else {
            XCTAssertTrue(false)
            return
        }
        
        self.testObject = fruitCell
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTextLabelNotNil() {
        XCTAssertNotNil(testObject.textLabel)
    }
 
    func testDetailTextLabelNotNil() {
        XCTAssertNotNil(testObject.detailTextLabel)
    }

    func testSetContentToNil() {
        testObject.content = nil
        XCTAssertNil(testObject.content)
        XCTAssertTrue(testObject.textLabel?.text == "Error", "textLabel should be : Error - is \((testObject.textLabel?.text)!)")
    }
    
    func testSetContentToWrongObjectClass() {
        testObject.content = Date()
        XCTAssertNotNil(testObject.content)
        XCTAssertTrue(testObject.detailTextLabel?.text == "no fruit object", "textLabel should be : no fruit object - is \((testObject.detailTextLabel?.text)!)")
    }
    
    func testSetContentToFruit() {
        testObject.content = Fruit(name: "Strawberry", category: .berry, price: 22.0)
        XCTAssertNotNil(testObject.content)
        XCTAssertTrue(testObject.textLabel?.text == "Strawberry", "textLabel should be : Strawberry - is \((testObject.textLabel?.text)!)")
        XCTAssertTrue(testObject.detailTextLabel?.text == "\(22.0)", "textLabel should be : 222.0 - is \((testObject.detailTextLabel?.text)!)")
    }
}
