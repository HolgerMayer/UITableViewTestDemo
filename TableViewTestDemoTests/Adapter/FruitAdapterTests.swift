//
//  FruitAdapterTests.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 09.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest
@testable import TableViewTestDemo

class FruitAdapterTests: XCTestCase {
    
    var testObject : FruitAdapter!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.testObject = FruitAdapter()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRegisterCells() {
        let tableView = MockTableView()
        
        self.testObject.registerCells(in: tableView)
        
        XCTAssertTrue(tableView.didRegisterNib)
        XCTAssertTrue(tableView.registeredIdentifier == "FruitTableViewCellID")
    }

    func testNumberOfSections(){
        XCTAssertTrue(self.testObject.numberOfSections() == 3)
    }
    
    func testNumberOfRowsForSection() {
        XCTAssertTrue(self.testObject.numberOfRowsInSection(section: 0) == 2)
        XCTAssertTrue(self.testObject.numberOfRowsInSection(section: 1) == 1)
        XCTAssertTrue(self.testObject.numberOfRowsInSection(section: 2) == 0)
        XCTAssertTrue(self.testObject.numberOfRowsInSection(section: 55) == 0)
    }
    
    func testCellIDFor() {
        XCTAssertTrue(self.testObject.cellIDFor(section: 0, row: 0) == "FruitTableViewCellID")
        XCTAssertTrue(self.testObject.cellIDFor(section: 1, row: 1) == "FruitTableViewCellID")
        XCTAssertTrue(self.testObject.cellIDFor(section: 2, row: 2) == "FruitTableViewCellID")
        XCTAssertTrue(self.testObject.cellIDFor(section: 55, row: 3) == "FruitTableViewCellID")
   }
   
    func testObjectForSection0(){
        let sectionObjectOK = self.testObject.objectFor(section: 0, row: 0)
        XCTAssertNotNil(sectionObjectOK)
        guard let _ = sectionObjectOK as? Fruit else {
            XCTAssertTrue(false,"Not a fruit")
            return
        }
        
        let sectionObjectToLarge = self.testObject.objectFor(section: 0, row: 14)
        XCTAssertNil(sectionObjectToLarge)
        
    }
    
    func testObjectForSection1(){
        let sectionObjectOK = self.testObject.objectFor(section: 1, row: 0)
        XCTAssertNotNil(sectionObjectOK)
        guard let _ = sectionObjectOK as? Fruit else {
            XCTAssertTrue(false,"Not a fruit")
            return
        }
        
        let sectionObjectToLarge = self.testObject.objectFor(section: 1, row: 14)
        XCTAssertNil(sectionObjectToLarge)

    }
   
    func testObjectForSection2Invalid(){
        let sectionObjectNil = self.testObject.objectFor(section: 2, row: 0)
        XCTAssertNil(sectionObjectNil)

    }
    
    func testObjectForSection55Invalid(){
        let sectionObjectNil = self.testObject.objectFor(section: 55, row: 0)
        XCTAssertNil(sectionObjectNil)
    }
    
}
