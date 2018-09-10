//
//  TableViewTestDemoUITests.swift
//  TableViewTestDemoUITests
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest

class TableViewTestDemoUITests: XCTestCase {
    
    var app : XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app = XCUIApplication()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
  
    
    func addBerry(){
        let tablesQuery = app.tables
        tablesQuery.otherElements["Berries"].children(matching: .button).element.tap()
        
    }
    
    func addApple(){
        let tablesQuery = app.tables
        tablesQuery.otherElements["Apples"].children(matching: .button).element.tap()
        
    }
    
    func addCherry(){
        let tablesQuery = app.tables
        tablesQuery.otherElements["Cherries"].children(matching: .button).element.tap()
        
    }
    
    func testExample()  {
        addBerry()
        addApple()
        addCherry()
    }
    
}
