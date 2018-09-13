//
//  CommonTableViewCellProtocol.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 12.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import Foundation

protocol EditableFruitTableViewCellDelegate {
    func editableFruitTableViewCellBeginEditing( _ cell:EditableFruitTableViewCell)
    func editableFruitTableViewCellValueDidChange( _ cell:EditableFruitTableViewCell, value : Any?)
    func editableFruitTableViewCellRequestUniqueNames(for section:Int)-> [String] 
}


protocol CommonTableViewCellProtocol {
    var section : Int {get set}
    var content : Any? {get set}
    var delegate : EditableFruitTableViewCellDelegate? { get set}

}
