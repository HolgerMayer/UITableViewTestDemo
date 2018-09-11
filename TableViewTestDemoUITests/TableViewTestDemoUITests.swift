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
    
    func deleteFruitWithSwipeBy(name : String) {
        let arrayobjecttableviewTable = app.tables["ArrayObjectTableView"]
        arrayobjecttableviewTable.cells[name].swipeLeft()
        arrayobjecttableviewTable.buttons["Delete"].tap()
    }
    
    func testAddDeleteWorkflow()  {
        let tableView = app.tables["ArrayObjectTableView"]

        let cells = XCUIApplication().tables.cells
        XCTAssertEqual(cells.count, 3, "found instead: \(cells.debugDescription)")
        
        addBerry()
        XCTAssertEqual(cells.count, 4, "found instead: \(cells.debugDescription)")
        let berryCell = tableView.cells["Berry 0"]
        XCTAssertTrue(berryCell.exists, "The berry cell should be in place on the table")
        
        addApple()
        XCTAssertEqual(cells.count, 5, "found instead: \(cells.debugDescription)")
        let appleCell = tableView.cells["Apple 0"]
        XCTAssertTrue(appleCell.exists, "The apple cell should be  in place on the table")
        
        addCherry()
        XCTAssertEqual(cells.count, 6, "found instead: \(cells.debugDescription)")
        let cherryCell = tableView.cells["Cherry 0"]
        XCTAssertTrue(cherryCell.exists, "The cherry cell should be in place on the table")

        deleteFruitWithSwipeBy(name: "Apple 0")
        XCTAssertEqual(cells.count, 5, "found instead: \(cells.debugDescription)")
        let noAppleCell = tableView.cells["Apple 0"]
        XCTAssertFalse(noAppleCell.exists, "The apple cell should not exist")

        deleteFruitWithSwipeBy(name: "Cherry 0")
        XCTAssertEqual(cells.count, 4, "found instead: \(cells.debugDescription)")
        let noCherryCell = tableView.cells["Cherry 0"]
        XCTAssertFalse(noCherryCell.exists, "The cherry cell should not exist")

        deleteFruitWithSwipeBy(name: "Berry 0")
        XCTAssertEqual(cells.count, 3, "found instead: \(cells.debugDescription)")
        let noBerryCell = tableView.cells["Berry 0"]
        XCTAssertFalse(noBerryCell.exists, "The berry cell should not exist")

        
   }
    
    func testNameGeneration(){
        let tableView = app.tables["ArrayObjectTableView"]
        let cells = XCUIApplication().tables.cells

        XCTAssertEqual(cells.count, 3, "found instead: \(cells.debugDescription)")
        var noBerryCell = tableView.cells["Berry 0"]
        XCTAssertFalse(noBerryCell.exists, "The berry 0 cell should not exist")

        noBerryCell = tableView.cells["Berry 1"]
        XCTAssertFalse(noBerryCell.exists, "The berry 1 cell should not exist")

        noBerryCell = tableView.cells["Berry 2"]
        XCTAssertFalse(noBerryCell.exists, "The berry 2 cell should not exist")

        addBerry()
        addBerry()
        addBerry()

        var berryCell = tableView.cells["Berry 0"]
        XCTAssertTrue(berryCell.exists, "The berry cell 0 should be  in place on the table")
        berryCell = tableView.cells["Berry 1"]
        XCTAssertTrue(berryCell.exists, "The berry cell 1 should be  in place on the table")
        berryCell = tableView.cells["Berry 2"]
        XCTAssertTrue(berryCell.exists, "The berry cell 2 should be  in place on the table")

        deleteFruitWithSwipeBy(name: "Berry 1")

        berryCell = tableView.cells["Berry 0"]
        XCTAssertTrue(berryCell.exists, "The berry cell 0 should be  in place on the table")
        noBerryCell = tableView.cells["Berry 1"]
        XCTAssertFalse(noBerryCell.exists, "The berry 1 cell should not exist")
        berryCell = tableView.cells["Berry 2"]
        XCTAssertTrue(berryCell.exists, "The berry cell 2 should be  in place on the table")

        addBerry()

        berryCell = tableView.cells["Berry 0"]
        XCTAssertTrue(berryCell.exists, "The berry cell 0 should be  in place on the table")
        berryCell = tableView.cells["Berry 1"]
        XCTAssertTrue(berryCell.exists, "The berry cell 1 should be  in place on the table")
        berryCell = tableView.cells["Berry 2"]
        XCTAssertTrue(berryCell.exists, "The berry cell 2 should be  in place on the table")

        addBerry()
        berryCell = tableView.cells["Berry 0"]
        XCTAssertTrue(berryCell.exists, "The berry cell 0 should be  in place on the table")
        berryCell = tableView.cells["Berry 1"]
        XCTAssertTrue(berryCell.exists, "The berry cell 1 should be  in place on the table")
        berryCell = tableView.cells["Berry 2"]
        XCTAssertTrue(berryCell.exists, "The berry cell 2 should be  in place on the table")
        berryCell = tableView.cells["Berry 3"]
        XCTAssertTrue(berryCell.exists, "The berry cell 3 should be  in place on the table")

    }
 
}
