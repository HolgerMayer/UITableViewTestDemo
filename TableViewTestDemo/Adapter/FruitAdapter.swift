//
//  FruitAdapter.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import UIKit

class FruitAdapter : ObjectAdapterProtocol {
    
    var model = Model()
    
    init(){
     }
    
    func registerCells(in tableView: UITableView) {
        let bundle = Bundle(for:FruitAdapter.self)
        tableView.register(UINib(nibName: "FruitTableViewCell", bundle: bundle), forCellReuseIdentifier: "FruitTableViewCellID")
    }

    
    func numberOfSections() -> Int {
        return 3 // three categories
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        switch section {
        case 0 :
            return (model.berrys()?.count)!
        case 1 :
            return (model.apples()?.count)!
        case 2 :
            return (model.cherries()?.count)!
        default :
            return 0
        }
    }
    
    func cellIDFor(section: Int, row: Int) -> String {
        return "FruitTableViewCellID"
    }
    
    func objectFor(section: Int, row: Int) -> Any? {
        switch (section,row) {
        case (0,_) :
            if row < (model.berrys()?.count)! {
                return model.berrys()?[row]
            } else {
                return nil
            }
         case (1,_) :
            if row < (model.apples()?.count)! {
                return model.apples()?[row]
            } else {
                return nil
            }
        case (2,_) :
            if row < (model.cherries()?.count)! {
                return model.cherries()?[row]
            } else {
                return nil
            }
      default :
            return nil
        }
    }
    
}
