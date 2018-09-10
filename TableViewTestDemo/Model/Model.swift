//
//  Model.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import Foundation


class Model {
    
    var data = [Fruit]()
    
    init(){
        data.append(Fruit(name: "Strawberry"))
        data.append(Fruit(name: "Raspberry"))
        data.append(Fruit(name: "Golden Delicious", category: .apple, price: 20.0))

    }
    
    func berrys() -> [Fruit]? {
        return data.filter{ $0.category == .berry }
    }
    
    func apples() -> [Fruit]? {
        return data.filter{ $0.category == .apple }
    }
    
    func cherries() -> [Fruit]? {
        return data.filter{ $0.category == .cherry }
    }
    
    
    func generateDefaultNameFor(category : FruitCategory) -> String {
        let templateString = category.rawValue
        
        let existingFruits = data.filter{ $0.category == category && $0.name.hasPrefix(templateString) }
        
        if existingFruits.count == 0 {
            return templateString + " 0"
        }
        
        for index in 0..<existingFruits.count {
            let checkName = templateString + " \(index)"
            if !existingFruits.contains(where:{$0.name == checkName }){
                return checkName
            }
        }
        
        
        return templateString + " \(existingFruits.count)"
    }
    
}
