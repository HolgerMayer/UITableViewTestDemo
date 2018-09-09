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
        let nib = UINib(nibName:"GroupHeaderView", bundle: bundle)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "GroupHeaderViewID")

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
    
    func sectionHeaderIDFor(section: Int) -> String {
        return "GroupHeaderViewID"
    }
    
    func sectionTitleFor(section:Int) -> String {
        switch section {
        case 0 :
            return "Berries"
        case 1 :
            return "Apples"
        case 2 :
            return "Cherries"
        default :
            return "Undefined"
        }
    }

    func addObjectTo(section:Int) -> IndexPath {
        let fruit = Fruit(name:"Noname")
        var row = 0
        switch section {
        case 0 :
            fruit.category = .berry
            self.model.data.append(fruit)
            let berries = self.model.berrys()
            row = berries!.index(of:fruit)!
            break
        case 1:
            fruit.category = .apple
            self.model.data.append(fruit)
             let apples = self.model.apples()
            row = apples!.index(of:fruit)!
           break
        case 2:
            fruit.category = .cherry
            self.model.data.append(fruit)
            let cherries = self.model.cherries()
            row = cherries!.index(of:fruit)!
            break
        default:
            break
        }
        return IndexPath(row: row, section: section)
    }

}
