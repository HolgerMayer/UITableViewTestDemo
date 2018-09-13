//
//  Fruit.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import Foundation

enum FruitCategory : String {
    case berry = "Berry"
    case apple = "Apple"
    case cherry = "Cherry"
}

class Fruit : NSObject {
    var name : String
    var price : Float
    var category : FruitCategory
    
    init(name : String, category : FruitCategory = .berry, price:Float=10.0) {
        self.name = name
        self.price = price
        self.category = category
    }
    
  
}
