//
//  FruitAdapter.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import Foundation

class FruitAdapter : ObjectAdapterProtocol {
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        switch section {
        case 0 :
            return 2
        default :
            return 1
        }
    }
    
    func cellIDFor(section: Int, row: Int) -> String {
        return "BasicCellID"
    }
    
    func objectFor(section: Int, row: Int) -> Any? {
        switch (section,row) {
        case (0,0) :
             return "Strawberry"
        case (0,1) :
            return "Raspberry"
        case (1,0) :
            return "Apple"
       default :
            return nil
        }
    }
    
}
