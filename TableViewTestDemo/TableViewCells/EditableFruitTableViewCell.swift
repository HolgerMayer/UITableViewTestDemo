//
//  EditableFruitTableViewCell.swift
//  TableViewTestDemo
//
//  Created by holgermayer on 12.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import UIKit


class EditableFruitTableViewCell: UITableViewCell, CommonTableViewCellProtocol{
    var content: Any? {
        didSet {
            self.priceValidator = FloatValidator()
            self.titleValidator = UniqueStringValidator()

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
    
  
    var section : Int = -1
    var delegate : EditableFruitTableViewCellDelegate?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!

    var priceValidator : ValidatorProtocol?
    var titleValidator : UniqueStringValidator?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleField.delegate = self
        priceField.delegate = self
    }

   
}


extension EditableFruitTableViewCell : UITextFieldDelegate {
    
    func replaceInString(_ text : String, range: NSRange, replacementString string: String ) -> String{
        let newString: String
        if
            let r = Range(range),
            case let start = text.utf16.index(text.utf16.startIndex, offsetBy: r.lowerBound),
            case let end = text.utf16.index(text.utf16.startIndex, offsetBy: r.upperBound),
            let startIndex = start.samePosition(in: text),
            let endIndex = end.samePosition(in: text)
        {
            newString = text.replacingCharacters(in: startIndex..<endIndex, with: string)
        } else {
            return text
        }
        return newString
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if self.delegate != nil     {
            self.delegate?.editableFruitTableViewCellBeginEditing(self)
        }
        
        setEditing(textField: textField)
        
        return true
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        setNoEditing(textField: textField)
        return true
        
     }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let _ = self.delegate else {
            return true
        }
        
        let text = textField.text ?? ""
        let fullString = replaceInString(text, range: range, replacementString: string)
        
        if textField == self.priceField {
            return validatePriceField(textField:textField, newString: fullString)
        } else { // nameField
            return validateNameField(textField: textField, newString: fullString)
        }
    }
    
    func validatePriceField(textField: UITextField, newString: String) -> Bool {
        guard let priceValidator = self.priceValidator else {
            return true
        }
        
        if priceValidator.validate(content: newString) == true {
            
            guard let fruit = content as? Fruit else {
                return false
            }
            
            let value = Float(newString)
            if value == nil {
                fruit.price = 0.0
            } else {
                fruit.price = value!
            }
            self.delegate?.editableFruitTableViewCellValueDidChange(self, value:fruit)
            
             return true
        }
        
        return false
    }
    
    func validateNameField(textField: UITextField, newString: String) -> Bool {
        
        guard let delegate = self.delegate else {
            return true
        }

        guard let titleValidator = self.titleValidator else {
            return true
        }
        
        let uniqueNames = delegate.editableFruitTableViewCellRequestUniqueNames(for: self.section)
        titleValidator.existingStrings = uniqueNames
        
        if titleValidator.validate(content: newString) == true {
            
            if self.delegate != nil     {
                guard let fruit = content as? Fruit else {
                    return false
                }
                
                fruit.name = newString
                self.delegate?.editableFruitTableViewCellValueDidChange(self, value:fruit)
  
          }
            return true
        }
        
        return false
        
    }
    
    func setNoEditing(textField : UITextField){
        textField.textColor = UIColor.black
        textField.backgroundColor  = UIColor.white
   }
    
    func setEditing(textField: UITextField) {
        textField.textColor = UIColor.blue
        textField.backgroundColor  = UIColor.white
    }
    
  
    
}
