//
//  DemoTableViewControllerTests.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest
@testable import TableViewTestDemo


class DemoTableViewControllerInitialSetupTests: XCTestCase {
    
    var testObject : DemoTableViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let bundle = Bundle(for: DemoTableViewController.self)
        let storyboard = UIStoryboard(name:"Main", bundle:bundle)
        self.testObject = storyboard.instantiateViewController(withIdentifier: "DemoTableViewControllerID") as? DemoTableViewController
        XCTAssertNotNil(self.testObject,"Testobject is nil")
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

    func testControllerDataSourceDoesNotExists(){
        XCTAssertNil(self.testObject?.dataSource)
    }
    
    func testNumberOfSections_NoDataSoure() {
        
        let sections = self.testObject.tableView.dataSource?.numberOfSections!(in: self.testObject.tableView)
        
        XCTAssertTrue(sections == 0)
        
    }
    

    func testNumberOfSections_NoDataSource() {
        
        let sections = self.testObject.tableView.dataSource?.numberOfSections!(in: self.testObject.tableView)
        
        XCTAssertTrue(sections == 0)
        
    }
    
    
    func testNumberOfRowsInSection_NoDataSource()  {
        
        let rows = self.testObject.tableView(self.testObject.tableView, numberOfRowsInSection: 1)
        
        XCTAssertTrue(rows == 0)
     }
    
    func testViewForHeader_NoDataSource() {
        
        let view = self.testObject.tableView(self.testObject.tableView, viewForHeaderInSection: 0)
        
        XCTAssertNil(view)
    }
    
    func testdidHitAddAction_NoDataSource(){
        
        self.testObject.dataSource = nil
        let mockTableView = MockTableView()
        let headerView = GroupHeaderView()
        
        self.testObject.didHitAddAction(headerView)
        
        XCTAssertFalse(mockTableView.didCall_insertRows_at)
    }
    
    func testEditButton_NoDataSource() {
         XCTAssertNil(self.testObject.navigationItem.rightBarButtonItem)
    }
    
    func testCommitEditingDelete_NoDataSource(){

        self.testObject.dataSource = nil
        let mockTableView = MockTableView()
        
        self.testObject.tableView(mockTableView, commit: .delete, forRowAt: IndexPath(row: 3, section: 2))
        
        XCTAssertFalse(mockTableView.didCall_deleteRows_at)

    }
    
    func testTableViewMoveRowAT_NoDataSource(){
        self.testObject.dataSource = nil
        let mockTableView = MockTableView()
        self.testObject.tableView(mockTableView, moveRowAt: IndexPath(row: 0, section: 1), to: IndexPath(row: 1, section: 1))
 
    }
    
    func testEditableFruitTableViewCellRequestUniqueNames_NoDataSource(){
        self.testObject.dataSource = nil
        let result = self.testObject.editableFruitTableViewCellRequestUniqueNames(for: 0)
        XCTAssertTrue(result.count == 0)
    }
    
}
