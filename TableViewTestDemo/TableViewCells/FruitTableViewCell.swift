//
//  FruitTableViewCell.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import UIKit

class FruitTableViewCell: UITableViewCell, CommonTableViewCellProtocol {
    

    var content : Any? {
        didSet {
            guard let fruit = content as? Fruit else {
                self.textLabel?.text = "Error"
                self.detailTextLabel?.text = "no fruit object"
                return
            }
            self.accessibilityIdentifier = fruit.name
            self.textLabel?.text = fruit.name
            self.detailTextLabel?.text = "\(fruit.price)"
        }
    }
 
    var delegate: EditableFruitTableViewCellDelegate?
    var section: Int = -1
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
}
