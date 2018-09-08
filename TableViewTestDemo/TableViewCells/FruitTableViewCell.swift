//
//  FruitTableViewCell.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 08.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import UIKit

class FruitTableViewCell: UITableViewCell {

    var content : Any? {
        didSet {
            guard let fruit = content as? Fruit else {
                self.textLabel?.text = "Error"
                self.detailTextLabel?.text = "no fruit object"
                return
            }
            self.textLabel?.text = fruit.name
            self.detailTextLabel?.text = "\(fruit.price)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
