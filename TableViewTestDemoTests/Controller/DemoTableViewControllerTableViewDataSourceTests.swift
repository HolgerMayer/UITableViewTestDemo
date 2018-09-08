//
//  DemoTableViewControllerTableViewDataSourceTests.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest
@testable import TableViewTestDemo

class DemoTableViewControllerTableViewDataSourceTests: XCTestCase {
    
    var testObject : DemoTableViewController!

    override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: DemoTableViewController.self)
        let storyboard = UIStoryboard(name:"Main", bundle:bundle)
        self.testObject = storyboard.instantiateViewController(withIdentifier: "DemoTableViewControllerID") as? DemoTableViewController
        XCTAssertNotNil(self.testObject,"Testobject is nil")
        self.testObject.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSections_NoSections() {
        
        // Setup
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForNumberOfSections = 0
        self.testObject.dataSource = mockAdapter
        
        // Run
        let sections = self.testObject.tableView.dataSource?.numberOfSections!(in: self.testObject.tableView)
        
        // Verify
        XCTAssertTrue(sections == 0)
        XCTAssertTrue(mockAdapter.didCall_numberOfSections)

    }
    
    func testNumberOfSections_OneSection() {
        
        // Setup
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForNumberOfSections = 1
        self.testObject?.dataSource = mockAdapter
        
        // Run
        let sections = self.testObject.tableView.dataSource?.numberOfSections!(in: self.testObject.tableView)
        
        // Verify
        XCTAssertTrue(sections == 1)
        XCTAssertTrue(mockAdapter.didCall_numberOfSections)
    }
    
    func testNumberOfSections_FourSections() {
        
        // Setup
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForNumberOfSections = 4
        self.testObject?.dataSource = mockAdapter
        
        // Run
        let sections = self.testObject.tableView.dataSource?.numberOfSections!(in: self.testObject.tableView)
        
        // Verify
        XCTAssertTrue(sections == 4)
        XCTAssertTrue(mockAdapter.didCall_numberOfSections)
    }
    
    func testNumberOfRowsInSection_NoRow() {
        
        // Setup
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForNumberOfRowsInSection = 0
        self.testObject?.dataSource = mockAdapter
        
        // Run
        let rows = self.testObject.tableView(self.testObject.tableView, numberOfRowsInSection: 1)
        
        // Verify
        XCTAssertTrue(rows == 0)
        XCTAssertTrue(mockAdapter.didCall_numberOfRowsInSection)
    }
    
    func testNumberOfRowsInSection_OneRow() {
        
        // Setup
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForNumberOfRowsInSection = 1
        self.testObject?.dataSource = mockAdapter
        
        // Run
        let rows = self.testObject.tableView(self.testObject.tableView, numberOfRowsInSection: 1)
        
        // Verify
        XCTAssertTrue(rows == 1)
        XCTAssertTrue(mockAdapter.didCall_numberOfRowsInSection)
    }
    
    func testNumberOfRowsInSection_FourRow() {
        
        // Setup
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForNumberOfRowsInSection = 1
        self.testObject?.dataSource = mockAdapter
        
        // Run
        let rows = self.testObject.tableView(self.testObject.tableView, numberOfRowsInSection: 1)
        
        // Verify
        XCTAssertTrue(rows == 1)
        XCTAssertTrue(mockAdapter.didCall_numberOfRowsInSection)
    }
    
    func testCellForSectionAndRowNoDataSourceAdapter() {
        
        // Setup
        
        // Run
        let cell = self.testObject.tableView(self.testObject.tableView, cellForRowAt: IndexPath(row: 1, section: 1))
        
        // Verify
        XCTAssertTrue(cell.textLabel?.text == "DataSource not set")
    }
   
    
    func testCellForSectionAndRow() {
        
        // Setup
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForCellID = "BasicCellID"
        mockAdapter.objectForSectionRow = "Dies ist ein Hugo"
        self.testObject?.dataSource = mockAdapter

        // Run
        let cell = self.testObject.tableView(self.testObject.tableView, cellForRowAt: IndexPath(row: 1, section: 1))
        
        // Verify
        XCTAssertTrue(mockAdapter.didCall_cellIDFor)
        XCTAssertTrue(mockAdapter.didCall_objectFor)
        XCTAssertTrue(cell.textLabel?.text ==  "Dies ist ein Hugo")
    }
    
    func testCellForSectionAndRow_WrongObjectType() {
        
        // Setup
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForCellID = "BasicCellID"
         self.testObject?.dataSource = mockAdapter
        
        // Run
        let cell = self.testObject.tableView(self.testObject.tableView, cellForRowAt: IndexPath(row: 1, section: 1))
        
        // Verify
        XCTAssertTrue(mockAdapter.didCall_cellIDFor)
        XCTAssertTrue(mockAdapter.didCall_objectFor)
        XCTAssertTrue(cell.textLabel?.text ==  "Object is no string")
    }
    
    func testCellForSectionAndRow_NoObject() {
        
        // Setup
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForCellID = "BasicCellID"
        mockAdapter.objectForSectionRow = nil
        self.testObject?.dataSource = mockAdapter

        // Run
        let cell = self.testObject.tableView(self.testObject.tableView, cellForRowAt: IndexPath(row: 1, section: 1))
        
        // Verify
        XCTAssertTrue(mockAdapter.didCall_cellIDFor)
        XCTAssertTrue(mockAdapter.didCall_objectFor)
        XCTAssertTrue(cell.textLabel?.text ==  "No object found")
    }
}
