//
//  EditableFruitTableViewCell.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 12.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import UIKit

protocol EditableFruitTableViewCellDelegate {
    func editableFruitTableViewCellBeginEditing( _ cell:EditableFruitTableViewCell)
    func editableFruitTableViewCellValueDidChange( _ cell:EditableFruitTableViewCell, value : Any?)
}


class EditableFruitTableViewCell: UITableViewCell, CommonTableViewCellProtocol{
    var content: Any? {
        didSet {
            if content == nil {
                self.titleField.text = ""
                self.priceField.text = ""
            } else {
                
                guard let fruit = content as? Fruit else {
                    self.titleField.text = "Wrong object class"
                    self.priceField.text = ""
                    return
                }
                self.accessibilityIdentifier = fruit.name
                
                self.titleField.text = fruit.name
                self.titleField.accessibilityIdentifier = fruit.name
                self.priceField.text = "\(fruit.price)"
            }
            
        }
    }
    
  
    
    var delegate : EditableFruitTableViewCellDelegate?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleField.delegate = self
        priceField.delegate = self
    }

   
}


extension EditableFruitTableViewCell : UITextFieldDelegate {
    
}
