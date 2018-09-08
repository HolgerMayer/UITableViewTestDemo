//
//  DemoTableViewControllerSetupWithDataSourceTests.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest
@testable import TableViewTestDemo

class DemoTableViewControllerSetupWithDataSourceTests: XCTestCase {
    
    var testObject : DemoTableViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let bundle = Bundle(for: DemoTableViewController.self)
        let storyboard = UIStoryboard(name:"Main", bundle:bundle)
        self.testObject = storyboard.instantiateViewController(withIdentifier: "DemoTableViewControllerID") as? DemoTableViewController
        XCTAssertNotNil(self.testObject,"Testobject is nil")
        self.testObject?.dataSource = FruitAdapter()
        self.testObject?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //
    // Teste korrektes Setup
    //
    
    func testTableViewExists(){
        XCTAssertNotNil(self.testObject?.tableView)
    }
    
    func testIsGrouped(){
        XCTAssertTrue(self.testObject?.tableView.style == .grouped)
    }
    
    func testTableViewDataSourceExists(){
        XCTAssertNotNil(self.testObject?.tableView.dataSource)
        XCTAssertTrue(self.testObject?.tableView.dataSource === self.testObject)
    }
    
    func testTableViewDelegateExists(){
        XCTAssertNotNil(self.testObject?.tableView.delegate)
        XCTAssertTrue(self.testObject?.tableView.delegate === self.testObject)
   }
    
    func testControllerDataSourceDoesExists(){
        XCTAssertNotNil(self.testObject?.dataSource)
    }
    
    
}
