//
//  GroupHeaderViewTests.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 09.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest
@testable import TableViewTestDemo

class GroupHeaderViewTests: XCTestCase {
    
    var testObject : GroupHeaderView!
    
    var didCall_didHitAddAction = false
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: DemoTableViewController.self)
        let storyboard = UIStoryboard(name:"Main", bundle:bundle)
        let controller = storyboard.instantiateViewController(withIdentifier: "DemoTableViewControllerID") as? DemoTableViewController
        let mockAdapter = ObjectAdapterMock()
        controller?.dataSource = mockAdapter
        controller?.loadViewIfNeeded()
        
        let headerView = controller?.tableView.dequeueReusableHeaderFooterView(withIdentifier: "GroupHeaderViewID")
        XCTAssertNotNil(headerView)
        guard let groupHeader = headerView as? GroupHeaderView else {
            XCTAssertTrue(false,"Header view is not of class GroupHeaderView")
            return
        }
        groupHeader.delegate = self
        self.testObject = groupHeader
        
        self.didCall_didHitAddAction = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialSectionIsZero() {
        XCTAssertTrue(testObject.section == 0)
        XCTAssertFalse(didCall_didHitAddAction)
    }
    
    func testSectionIsUpdateable() {
        testObject.section = 3
        XCTAssertTrue(testObject.section == 3)
        XCTAssertFalse(didCall_didHitAddAction)
   }

    func testHeaderLabelIsAvailable(){
        XCTAssertNotNil(testObject.headerLabel)
        XCTAssertFalse(didCall_didHitAddAction)
   }
    
    func testAddAction(){
        testObject.addAction()
        XCTAssertTrue(didCall_didHitAddAction)
   }

    func testAddActionNoDelegate(){
        testObject.delegate = nil
        testObject.addAction()
        XCTAssertFalse(didCall_didHitAddAction)
    }

    
}

extension GroupHeaderViewTests : GroupHeaderViewDelegate {
    func didHitAddAction(_ headerView: GroupHeaderView) {
        self.didCall_didHitAddAction = true
        XCTAssertTrue(headerView === testObject)
    }
    
    
}
