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
}
