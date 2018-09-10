//
//  ObjectAdapterProtocol.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import UIKit


protocol ObjectAdapterProtocol {
    func registerCells(in tableView: UITableView)
    func numberOfSections() -> Int
    func numberOfRowsInSection(section:Int) -> Int
    func cellIDFor(section:Int, row:Int) -> String
    func objectFor(section:Int, row:Int) -> Any?
    func sectionHeaderIDFor(section: Int) -> String
    func sectionTitleFor(section:Int) -> String
    func addObjectTo(section:Int) -> IndexPath
    func deleteObjectFor(section:Int, row:Int)
}
