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
        let tableView = app.tables["ArrayObjectTableView"]
        
        tableView.textFields[name].swipeLeft()
        tableView.buttons["Delete"].tap()
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
 
    
    func testReorder(){
        
        
        let app = XCUIApplication()
        let tableView = app.tables["ArrayObjectTableView"]
        let addbuttonButton = tableView.otherElements["Apples"].buttons["addButton"]
        addbuttonButton.tap()
        addbuttonButton.tap()
        
        let demotableNavigationBar = app.navigationBars["DemoTable"]
        demotableNavigationBar.buttons["Edit"].tap()
        
         let reorderApple1100Button = tableView.cells.containing(.textField, identifier:"Apple 1").buttons["Reorder"]
          let reorderGoldenDecliciousButton = tableView.cells.containing(.textField, identifier:"Golden Delicious").buttons["Reorder"]
        
        let reorderStrawberry100Button = tableView.cells.containing(.textField, identifier:"Strawberry").buttons["Reorder"]

        reorderGoldenDecliciousButton.press(forDuration: 0.5, thenDragTo: reorderApple1100Button)
        reorderApple1100Button.press(forDuration: 0.5, thenDragTo: reorderStrawberry100Button)

        demotableNavigationBar.buttons["Done"].tap()
        
        // Offset 2 because of berrys !!!
        let cell0 = tableView.cells.allElementsBoundByIndex[2]
        let cell1 = tableView.cells.allElementsBoundByIndex[3]
        let cell2 = tableView.cells.allElementsBoundByIndex[4]
        XCTAssertTrue(cell0.identifier == "Apple 1", "Identifier should b Apple 1 is >\(cell0.identifier)<")
        XCTAssertTrue(cell1.identifier == "Apple 0", "Identifier should b Apple 0 is >\(cell1.identifier)<")
        XCTAssertTrue(cell2.identifier == "Golden Delicious", "Identifier should be Golden Deliciousis >\(cell2.identifier)<")

    }
}
