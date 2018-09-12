//
//  MockTableView.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 09.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import UIKit

class MockTableView: UITableView {

    var didCall_registerNib = false
    var didCall_deleteRows_at = false
    var didCall_insertRows_at = false
    
    var value_numberOfRowsInSection = -1
    
    var registeredIdentifier = [String]()
    var parameterIndexPaths : [IndexPath]?
    
    override func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        didCall_registerNib = true
        registeredIdentifier.append(identifier)
    }

    override func deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        didCall_deleteRows_at = true
        parameterIndexPaths = indexPaths
    }
  
    override func insertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        didCall_insertRows_at = true
        parameterIndexPaths = indexPaths
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return value_numberOfRowsInSection
    }
}
