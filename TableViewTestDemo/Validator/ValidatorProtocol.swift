//
//  ValidatorProtocol.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 12.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import Foundation


public protocol ValidatorProtocol {
    func validate(content: String) -> Bool
}
