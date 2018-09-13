//
//  FloatValidator.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 12.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import Foundation

public class FloatValidator: RegularExpressionValidator {
    
    
    public override init() {
        super.init()
        
        super.setRegularExpression(expressionPattern: "(^-?[0-9]*\\.?[0-9]*([eE][+-]?[0-9]*)?$)")
        
    }
    
    
    
}
