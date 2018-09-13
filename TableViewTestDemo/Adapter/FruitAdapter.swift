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
        tableView.register(UINib(nibName: "EditableFruitTableViewCell", bundle: bundle), forCellReuseIdentifier: "EditableFruitTableViewCellID")
      let nib = UINib(nibName:"GroupHeaderView", bundle: bundle)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "GroupHeaderViewID")

    }

    
    func numberOfSections() -> Int {
        return 3 // three categories
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        switch section {
        case 0 :
            return model.berrys().count
        case 1 :
            return model.apples().count
        case 2 :
            return model.cherries().count
        default :
            return 0
        }
    }
    
    func cellIDFor(section: Int, row: Int) -> String {
        return "EditableFruitTableViewCellID"
    }
    
    func objectFor(section: Int, row: Int) -> Any? {
        switch (section,row) {
        case (0,_) :
            if row < model.berrys().count {
                return model.berrys()[row]
            } else {
                return nil
            }
         case (1,_) :
            if row < model.apples().count {
                return model.apples()[row]
            } else {
                return nil
            }
        case (2,_) :
            if row < model.cherries().count {
                return model.cherries()[row]
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
         var row = 0
        switch section {
        case 0 :
            let fruit = Fruit(name:model.generateDefaultNameFor(category: .berry))
            fruit.category = .berry
            self.model.data.append(fruit)
            let berries = self.model.berrys()
            row = berries.index(of:fruit)!
            break
        case 1:
            let fruit = Fruit(name:model.generateDefaultNameFor(category: .apple))
            fruit.category = .apple
            self.model.data.append(fruit)
             let apples = self.model.apples()
            row = apples.index(of:fruit)!
           break
        case 2:
            let fruit = Fruit(name:model.generateDefaultNameFor(category: .cherry))
            fruit.category = .cherry
            self.model.data.append(fruit)
            let cherries = self.model.cherries()
            row = cherries.index(of:fruit)!
            break
        default:
            break
        }
        return IndexPath(row: row, section: section)
    }

 
    
    func deleteObjectFor(section: Int, row: Int) {
        let object = objectFor(section: section, row: row)
        
        let fruit = object as? Fruit
        
        if fruit != nil {
            let objectIndex = model.data.index(of: fruit!)
            if objectIndex != nil {
                 model.data.remove(at:objectIndex!)
           }
        }
    }

    func moveRowAtSection(sourceSection:Int, moveRowAtRow sourceRow:Int, toDestinationSection destinationSection:Int, destinationRow:Int){
        let movedFruit = self.objectFor(section: sourceSection,row: sourceRow) as? Fruit
        let targetFruit = self.objectFor(section: destinationSection,row: destinationRow) as? Fruit
        self.deleteObjectFor(section: sourceSection, row: sourceRow)

        if destinationSection < sourceSection {
            self.model.data.insert(movedFruit!, at:0)
        } else if destinationSection > sourceRow {
            self.model.data.insert(movedFruit!, at: self.model.data.endIndex)
        } else { // same section
            let index = self.model.data.index(of: targetFruit!)
            if index != nil {
                self.model.data.insert(movedFruit!, at: index!)
            } else {
                self.model.data.insert(movedFruit!, at: self.model.data.endIndex)
          }
        }
    }
    

    func uniqueNames(for section: Int) -> [String] {
        switch section {
        case 0 :
            let data = model.berrys()
            return data.map{ $0.name}
        case 1:
           let data = model.apples()
            return data.map{ $0.name}
        case 2:
            let data = model.cherries()
            return data.map{ $0.name}
        default:
            return [String]()
        }
    }
}
