//
//  ObjectAdapterProtocol.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import Foundation


protocol ObjectAdapterProtocol {
    func numberOfSections() -> Int
    func numberOfRowsInSection(section:Int) -> Int
    func cellIDFor(section:Int, row:Int) -> String
    func objectFor(section:Int, row:Int) -> Any?
}
