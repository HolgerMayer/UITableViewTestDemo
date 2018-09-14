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
        self.testObject.loadViewIfNeeded()

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
        self.testObject.loadViewIfNeeded()

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
        self.testObject.loadViewIfNeeded()

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
        self.testObject.loadViewIfNeeded()

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
        self.testObject.loadViewIfNeeded()

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
        self.testObject.loadViewIfNeeded()

        // Run
        let rows = self.testObject.tableView(self.testObject.tableView, numberOfRowsInSection: 1)
        
        // Verify
        XCTAssertTrue(rows == 1)
        XCTAssertTrue(mockAdapter.didCall_numberOfRowsInSection)
    }
    
    func testCellForSectionAndRowNoDataSourceAdapter() {
        
        // Setup
        self.testObject.loadViewIfNeeded()

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
        self.testObject.loadViewIfNeeded()

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
        self.testObject.loadViewIfNeeded()

        // Run
        let cell = self.testObject.tableView(self.testObject.tableView, cellForRowAt: IndexPath(row: 1, section: 1))
        
        // Verify
        XCTAssertTrue(mockAdapter.didCall_cellIDFor)
        XCTAssertTrue(mockAdapter.didCall_objectFor)
        XCTAssertTrue(cell.textLabel?.text ==  "Object is no string")
    }
    
    func testCellForSectionAndRow_FruitType() {
        
        // Setup
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForCellID = "FruitTableViewCellID"
        mockAdapter.objectForSectionRow = Fruit(name: "Strawberry", category: .berry, price: 22.0)
        self.testObject?.dataSource = mockAdapter
        self.testObject.loadViewIfNeeded()

        // Run
        let cell = self.testObject.tableView(self.testObject.tableView, cellForRowAt: IndexPath(row: 1, section: 1))
        
        // Verify
        XCTAssertTrue(mockAdapter.didCall_cellIDFor)
        XCTAssertTrue(mockAdapter.didCall_objectFor)
        XCTAssertTrue(cell.textLabel?.text ==  "Strawberry")
        XCTAssertTrue(cell.detailTextLabel?.text ==  "\(22.0)")
    }
    
    
    func testCellForSectionAndRow_NoObject() {
        
        // Setup
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForCellID = "BasicCellID"
        mockAdapter.objectForSectionRow = nil
        self.testObject?.dataSource = mockAdapter
        self.testObject.loadViewIfNeeded()

        // Run
        let cell = self.testObject.tableView(self.testObject.tableView, cellForRowAt: IndexPath(row: 1, section: 1))
        
        // Verify
        XCTAssertTrue(mockAdapter.didCall_cellIDFor)
        XCTAssertTrue(mockAdapter.didCall_objectFor)
        XCTAssertTrue(cell.textLabel?.text ==  "No object found")
    }
    
    func testHeaderViewHeight(){
        
        let height = self.testObject.tableView(self.testObject.tableView, heightForHeaderInSection: 0)
        
        XCTAssertTrue(height == 68.0)
    }
    
    func testFooterViewHeight(){
        
        let height = self.testObject.tableView(self.testObject.tableView, heightForFooterInSection: 0)
        
        XCTAssertTrue(height == 0.0)
    }
    
    
    func testHeaderViewCreation(){
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForHeaderTitle = "Hugo 123"
        self.testObject.dataSource = mockAdapter
        self.testObject.loadViewIfNeeded()
        
        let view = self.testObject.tableView(self.testObject.tableView, viewForHeaderInSection: 2)
        XCTAssertNotNil(view)
        guard let groupHeaderView = view as? GroupHeaderView else {
            XCTAssertTrue(false,"headerView is not of class GourpheaderView")
            return
        }
        
        XCTAssertNotNil(groupHeaderView.delegate)
        XCTAssertTrue(groupHeaderView.section == 2)
        XCTAssertTrue(groupHeaderView.headerLabel.text == "Hugo 123")
        
    }

    func testController_didHitAddAction(){
        let adapter = FruitAdapter()
        self.testObject.dataSource = adapter
        self.testObject.loadViewIfNeeded()
        
        let totalCount = adapter.model.data.count
        let berryCount = adapter.model.berrys().count

        let groupHeader = self.testObject.tableView(self.testObject.tableView, viewForHeaderInSection: 0) as! GroupHeaderView
        XCTAssertNotNil(groupHeader)
        
        self.testObject.didHitAddAction(groupHeader)
        
        XCTAssertTrue(totalCount + 1 == adapter.model.data.count)
        XCTAssertTrue(berryCount + 1 == adapter.model.berrys().count)

    }
    
    func testCommitEditingDelete(){
        let mockAdapter = ObjectAdapterMock()
        self.testObject.dataSource = mockAdapter
        
        let mockTableView = MockTableView()
        
        self.testObject.tableView(mockTableView, commit: .delete, forRowAt: IndexPath(row: 3, section: 2))

        XCTAssertTrue(mockTableView.didCall_deleteRows_at)
        XCTAssertNotNil(mockTableView.parameterIndexPaths)
        XCTAssertTrue(mockTableView.parameterIndexPaths?.count == 1)
        let indexPath = mockTableView.parameterIndexPaths![0]
        XCTAssertTrue(indexPath.row == 3)
        XCTAssertTrue(indexPath.section == 2)
        XCTAssertTrue(mockAdapter.didCall_deleteObjectFor)
        XCTAssertTrue(mockAdapter.parameterSection == 2)
        XCTAssertTrue(mockAdapter.parameterRow == 3)
        
    }
   
    func testTableViewMoveRowAt(){
        let mockAdapter = ObjectAdapterMock()
        self.testObject.dataSource = mockAdapter
        
        let mockTableView = MockTableView()
        
        self.testObject.tableView(mockTableView, moveRowAt: IndexPath(row: 0, section: 1), to: IndexPath(row: 3, section: 2))
        
        XCTAssertTrue(mockAdapter.didCall_moveRowAtSection)
        XCTAssertTrue(mockAdapter.parameterSection == 1)
        XCTAssertTrue(mockAdapter.parameterRow == 0)
        XCTAssertTrue(mockAdapter.parameter1Section == 2)
        XCTAssertTrue(mockAdapter.parameter1Row == 3)

    }
    
    func testTableViewtargetIndexPathForMoveFromRowAt_LowerDestinationSection(){
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForNumberOfRowsInSection = 5
        let mockTableView = MockTableView()
        
        let indexPath = self.testObject.tableView(mockTableView, targetIndexPathForMoveFromRowAt: IndexPath(row: 3, section: 4), toProposedIndexPath: IndexPath(row: 2, section: 2))
        
        XCTAssertTrue(indexPath.section == 4)
        XCTAssertTrue(indexPath.row == 0)
    }
    
    
    func testTableViewtargetIndexPathForMoveFromRowAt_SameDestinationSection(){
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForNumberOfRowsInSection = 5
        let mockTableView = MockTableView()
        
        let indexPath = self.testObject.tableView(mockTableView, targetIndexPathForMoveFromRowAt: IndexPath(row: 3, section: 4), toProposedIndexPath: IndexPath(row: 2, section: 4))
        
        XCTAssertTrue(indexPath.section == 4)
        XCTAssertTrue(indexPath.row == 2)

    }
    
    func testTableViewtargetIndexPathForMoveFromRowAt_HigherDestinationSection(){
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForNumberOfRowsInSection = 7
        self.testObject.dataSource = mockAdapter
        
        let indexPath = self.testObject.tableView(self.testObject.tableView, targetIndexPathForMoveFromRowAt: IndexPath(row: 3, section: 4), toProposedIndexPath: IndexPath(row: 2, section: 8))
        
        XCTAssertTrue(indexPath.section == 4)
        XCTAssertTrue(indexPath.row == 6,"Row should be 6 is \(indexPath.row)" )

    }
    
    func testEditableFruitTableViewCellRequestUniqueNames(){
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForUniqueNames = ["Demo Example"]
        self.testObject.dataSource = mockAdapter
        
        let result = self.testObject.editableFruitTableViewCellRequestUniqueNames(for: 0)
        XCTAssertTrue(result.count == 1)
        XCTAssertTrue(result[0] == "Demo Example")
        XCTAssertTrue(mockAdapter.didCall_UniqueNames)
    }
    
    func testEditableFruitTableViewCellBeginEditing(){
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForCellID = "EditableFruitTableViewCellID"
        mockAdapter.valueForUniqueNames = ["Demo Example"]
        self.testObject.dataSource = mockAdapter
        let cell = self.testObject.tableView(self.testObject.tableView, cellForRowAt: IndexPath(row: 1, section: 1)) as! EditableFruitTableViewCell
        
        self.testObject.editableFruitTableViewCellBeginEditing(cell)
     }
    
    func testEditableFruitTableViewCellValueDidChange(){
        let mockAdapter = ObjectAdapterMock()
        mockAdapter.valueForCellID = "EditableFruitTableViewCellID"
        mockAdapter.valueForUniqueNames = ["Demo Example"]
        self.testObject.dataSource = mockAdapter
        let cell = self.testObject.tableView(self.testObject.tableView, cellForRowAt: IndexPath(row: 1, section: 1)) as! EditableFruitTableViewCell

        self.testObject.editableFruitTableViewCellValueDidChange(cell, value: "Demo")
    }
}
