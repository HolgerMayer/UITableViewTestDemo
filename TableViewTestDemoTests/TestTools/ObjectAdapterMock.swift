//
//  ObjectAdapterMock.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import UIKit
@testable import TableViewTestDemo

class ObjectAdapterMock : ObjectAdapterProtocol {
 
    
    
    
    
    var didCall_registerCells = false
    var didCall_numberOfSections  = false
    var didCall_numberOfRowsInSection  = false
    var didCall_cellIDFor  = false
    var didCall_objectFor  = false
    var didCall_sectionHeaderIDFor = false
    var didCall_sectionTitleFor = false
    var didCall_addObjectTo = false
    var didCall_deleteObjectFor = false
    var didCall_moveRowAtSection = false
    
    var valueForNumberOfSections : Int = 0
    var valueForNumberOfRowsInSection : Int = 0
    var valueForCellID : String = "Hugo"
    var objectForSectionRow : Any? = Date()
    var valueForHeaderTitle = "Header Title"
    var valueForInsertIndexPath = IndexPath(row: 0, section: 0)
    var parameterSection = -1
    var parameterRow = -1
    var parameter1Section = -1
    var parameter1Row = -1

    func registerCells(in tableView: UITableView) {
        didCall_registerCells = true
        let bundle = Bundle(for:FruitAdapter.self)
        tableView.register(UINib(nibName: "FruitTableViewCell", bundle: bundle), forCellReuseIdentifier: "FruitTableViewCellID")
        
        let nib = UINib(nibName:"GroupHeaderView", bundle: bundle)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "GroupHeaderViewID")

    }

    
    func numberOfSections() -> Int {
        didCall_numberOfSections = true
        return valueForNumberOfSections
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        didCall_numberOfRowsInSection = true
        return valueForNumberOfRowsInSection
    }
    
    func cellIDFor(section: Int, row: Int) -> String {
        didCall_cellIDFor = true
        return valueForCellID
    }
    
    func objectFor(section: Int, row: Int) -> Any? {
        didCall_objectFor = true
        return objectForSectionRow
    }
    
    func sectionHeaderIDFor(section: Int) -> String {
        didCall_sectionHeaderIDFor = true
        return "GroupHeaderViewID"
    }

    func sectionTitleFor(section:Int) -> String
    {
        didCall_sectionTitleFor = true
        return valueForHeaderTitle
    }
    
    func addObjectTo(section:Int) -> IndexPath {
        didCall_addObjectTo = true
        return valueForInsertIndexPath
    }
    
    func deleteObjectFor(section: Int, row: Int) {
        didCall_deleteObjectFor = true
        parameterSection = section
        parameterRow = row
    }

    func moveRowAtSection(sourceSection: Int, moveRowAtRow sourceRow: Int, toDestinationSection destinationSection: Int, destinationRow: Int) {
        didCall_moveRowAtSection = true
        parameterSection = sourceSection
        parameterRow = sourceRow
        parameter1Section = destinationSection
        parameter1Row = destinationRow
    }
    
}
