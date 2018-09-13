//
//  RegularExpressionValidator.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 13.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import Foundation


public class RegularExpressionValidator: NSObject, ValidatorProtocol {
    
    var regularExpression : NSRegularExpression?
    var patternOK : Bool = false
    
    public override init() {
        super.init()
    }
    
    public func setRegularExpression(expressionPattern: String){
        do {
            self.regularExpression = try NSRegularExpression(pattern:expressionPattern, options: NSRegularExpression.Options.caseInsensitive)
            patternOK = true
        } catch {
            patternOK = false
            print(error)
        }
    }
    
    public func validate(content: String) -> Bool {
        if (self.regularExpression?.numberOfMatches(in: content, options: .reportProgress, range: NSMakeRange(0, content.count)))! <= 0  {
            return false
        }
        return true
        
    }
    
}
