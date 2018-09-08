//
//  MockTableView.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 09.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import UIKit

class MockTableView: UITableView {

    var didRegisterNib = false
    var registeredIdentifier : String = ""
    
    
    override func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        didRegisterNib = true
        registeredIdentifier = identifier
    }

  
}
