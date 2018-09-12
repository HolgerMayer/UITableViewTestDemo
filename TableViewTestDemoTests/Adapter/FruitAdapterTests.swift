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
        
        XCTAssertTrue(tableView.didCall_registerNib)
        XCTAssertNotNil(tableView.registeredIdentifier.filter({ $0 == "EditableFruitTableViewCellID" }).first)
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
        XCTAssertTrue(self.testObject.cellIDFor(section: 0, row: 0) == "EditableFruitTableViewCellID")
        XCTAssertTrue(self.testObject.cellIDFor(section: 1, row: 1) == "EditableFruitTableViewCellID")
        XCTAssertTrue(self.testObject.cellIDFor(section: 2, row: 2) == "EditableFruitTableViewCellID")
        XCTAssertTrue(self.testObject.cellIDFor(section: 55, row: 3) == "EditableFruitTableViewCellID")
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
    
    func testGroupHeaderViewID(){
        XCTAssertTrue(testObject.sectionHeaderIDFor(section: 0) == "GroupHeaderViewID")
    }
    
    func testGroupHeaderViewIDSectionOutOfBounds(){
        XCTAssertTrue(testObject.sectionHeaderIDFor(section: 55) == "GroupHeaderViewID")
    }
    
    func testGroupHeaderTitle(){
        XCTAssertTrue(testObject.sectionTitleFor(section:0)  == "Berries")
        XCTAssertTrue(testObject.sectionTitleFor(section:1)  == "Apples")
        XCTAssertTrue(testObject.sectionTitleFor(section:2)  == "Cherries")
        XCTAssertTrue(testObject.sectionTitleFor(section:55)  == "Undefined")
   }
    
    func testAddObjectForSection0(){
        let totalCount = self.testObject.model.data.count
        let berryCount = (self.testObject.model.berrys()?.count)!
        
        let _ = self.testObject.addObjectTo(section: 0)
 
        XCTAssertTrue(totalCount + 1 == self.testObject.model.data.count)
        XCTAssertTrue(berryCount + 1 == (self.testObject.model.berrys()?.count)!)
    }
    
    func testAddObjectForSection1(){
        let totalCount = self.testObject.model.data.count
        let appleCount = (self.testObject.model.apples()?.count)!
        
        let _ = self.testObject.addObjectTo(section: 1)
        
        XCTAssertTrue(totalCount + 1 == self.testObject.model.data.count)
        XCTAssertTrue(appleCount + 1 == (self.testObject.model.apples()?.count)!)
    }
    
    func testAddObjectForSection2(){
        let totalCount = self.testObject.model.data.count
        let cherryCount = (self.testObject.model.cherries()?.count)!
        
        let index = self.testObject.addObjectTo(section: 2)
        
        XCTAssertTrue(totalCount + 1 == self.testObject.model.data.count)
        XCTAssertTrue(cherryCount + 1 == (self.testObject.model.cherries()?.count)!)
        
        let fruit = self.testObject.objectFor(section: index.section, row: index.row)
        guard let cherry = fruit as? Fruit else {
            XCTAssertTrue(false,"Object is  not a fruit")
            return
        }
        XCTAssertTrue(cherry.category == .cherry)
        XCTAssertTrue(cherry.name == "Cherry 0")
    }
    
    func testAddObjectForInvalidSection(){
        let totalCount = self.testObject.model.data.count
        
        let _ = self.testObject.addObjectTo(section: 55)
        
        XCTAssertTrue(totalCount == self.testObject.model.data.count)
 
    }
    
    func testDeleteObjectValidIndexPath(){
        XCTAssertTrue((self.testObject.model.apples()?.count)! == 1)
        self.testObject.deleteObjectFor(section: 1, row: 0)
        XCTAssertTrue((self.testObject.model.apples()?.count)! == 0)

    }
    
    func testDeleteObjectInValidIndexPath(){
        let totalCount = self.testObject.model.data.count
        self.testObject.deleteObjectFor(section: 55, row: 0)
        XCTAssertTrue(self.testObject.model.data.count == totalCount)

    }
    
    func testMoveRowAtSectionToNextSection(){
        let appleCount = (self.testObject.model.apples()?.count)!
        
        let _ = self.testObject.addObjectTo(section: 1)
        let _ = self.testObject.addObjectTo(section: 1)
        XCTAssertTrue(appleCount + 2 == (self.testObject.model.apples()?.count)!)
        
        // Move Center Row to Next Section
        let centerObject = self.testObject.model.apples()![1]
        
        self.testObject.moveRowAtSection(sourceSection: 1, moveRowAtRow: 1, toDestinationSection: 2, destinationRow: 1)
        XCTAssertTrue(appleCount + 2 == (self.testObject.model.apples()?.count)!)

        let lastObject = self.testObject.model.apples()![2]
        
        XCTAssertTrue(centerObject.name == lastObject.name)
        
    }
    
    
    func testMoveRowAtSectionToPreviousSection() {
        let appleCount = (self.testObject.model.apples()?.count)!
        
        let _ = self.testObject.addObjectTo(section: 1)
        let _ = self.testObject.addObjectTo(section: 1)
        XCTAssertTrue(appleCount + 2 == (self.testObject.model.apples()?.count)!)

        // Move Center Row To previous Section
        let centerObject = self.testObject.model.apples()![1]
        
        self.testObject.moveRowAtSection(sourceSection: 1, moveRowAtRow: 1, toDestinationSection: 0, destinationRow: 1)
        XCTAssertTrue(appleCount + 2 == (self.testObject.model.apples()?.count)!)
        
        let firstObject = self.testObject.model.apples()![0]
        XCTAssertTrue(centerObject.name == firstObject.name)
        
    }
    
    func testMoveRowAtSectionToFirstRowInSection(){
        let appleCount = (self.testObject.model.apples()?.count)!
        
        let _ = self.testObject.addObjectTo(section: 1)
        let _ = self.testObject.addObjectTo(section: 1)
        XCTAssertTrue(appleCount + 2 == (self.testObject.model.apples()?.count)!)
        
        // Move Center Row To previous Section
        let centerObject = self.testObject.model.apples()![1]
        
        self.testObject.moveRowAtSection(sourceSection: 1, moveRowAtRow: 1, toDestinationSection: 1, destinationRow: 0)
        XCTAssertTrue(appleCount + 2 == (self.testObject.model.apples()?.count)!)
        
        let firstObject = self.testObject.model.apples()![0]
        XCTAssertTrue(centerObject.name == firstObject.name)
    }
        // Move CEnter Row to first Enty in Section
        
    func testMoveRowAtSectionToSecondRowInSection(){
        let appleCount = (self.testObject.model.apples()?.count)!
        
        let _ = self.testObject.addObjectTo(section: 1)
        let _ = self.testObject.addObjectTo(section: 1)
        XCTAssertTrue(appleCount + 2 == (self.testObject.model.apples()?.count)!)
        
        // Move Center Row To previous Section
        let centerObject = self.testObject.model.apples()![2]
        
        self.testObject.moveRowAtSection(sourceSection: 1, moveRowAtRow: 1, toDestinationSection: 1, destinationRow: 1)
        XCTAssertTrue(appleCount + 2 == (self.testObject.model.apples()?.count)!)
        
        let firstObject = self.testObject.model.apples()![1]
        XCTAssertTrue(centerObject.name == firstObject.name)
    }

  
  
}
