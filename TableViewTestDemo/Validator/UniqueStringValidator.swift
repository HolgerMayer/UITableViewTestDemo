//
//  UniqueStringValidator.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 12.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import Foundation

public class UniqueStringValidator: NSObject, ValidatorProtocol {
    
    var existingStrings : [String]?
    
    public override init() {
        super.init()
     }
    
    
    public func validate(content: String) -> Bool {
        
        guard let testString = self.existingStrings else {
            return true
        }
        
        let existingItems = testString.filter{ $0 == content }
        
        if existingItems.count < 1 {
            return true
        }
        
        return false
    }
    
}
