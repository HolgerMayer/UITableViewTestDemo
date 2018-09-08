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

    
    var valueForNumberOfSections : Int = 0
    var valueForNumberOfRowsInSection : Int = 0
    var valueForCellID : String = "Hugo"
    var objectForSectionRow : Any? = Date()
    
    func registerCells(in tableView: UITableView) {
        didCall_registerCells = true
        let bundle = Bundle(for:FruitAdapter.self)
        tableView.register(UINib(nibName: "FruitTableViewCell", bundle: bundle), forCellReuseIdentifier: "FruitTableViewCellID")
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
    
    
}
