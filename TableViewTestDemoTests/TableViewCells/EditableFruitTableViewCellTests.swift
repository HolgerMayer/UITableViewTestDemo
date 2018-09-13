//
//  EditableFruitTableViewCellTests.swift
//  TableViewTestDemoTests
//
//  Created by holgermayer on 12.09.18.
//  Copyright © 2018 holgermayer. All rights reserved.
//

import XCTest
@testable import TableViewTestDemo

class EditableFruitTableViewCellTests: XCTestCase {
    
    var testObject : EditableFruitTableViewCell!
    var mockAdapter : ObjectAdapterMock?
    
    var didCall_editableFruitTableViewCellBeginEditing = false
    var didCall_editableFruitTableViewCellValueDidChange = false
    var didCall_editableFruitTableViewCellRequestUniqueNames = false
    var value_UniqueValues = [String]()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: DemoTableViewController.self)
        let storyboard = UIStoryboard(name:"Main", bundle:bundle)
        let controller = storyboard.instantiateViewController(withIdentifier: "DemoTableViewControllerID") as? DemoTableViewController
        mockAdapter = ObjectAdapterMock()
        controller?.dataSource = mockAdapter
        controller?.loadViewIfNeeded()
        
        let cell = controller?.tableView?.dequeueReusableCell(withIdentifier: "EditableFruitTableViewCellID")
        XCTAssertNotNil(cell)
        guard let fruitCell = cell as? EditableFruitTableViewCell else {
            XCTAssertTrue(false)
            return
        }
        
        self.testObject = fruitCell
        self.testObject.delegate = self
        
        didCall_editableFruitTableViewCellBeginEditing = false
        didCall_editableFruitTableViewCellValueDidChange = false
        didCall_editableFruitTableViewCellRequestUniqueNames = false

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTitleFieldNotNil() {
        XCTAssertNotNil(testObject.titleField)
    }
    
    func testPriceFieldNotNil() {
        XCTAssertNotNil(testObject.priceField)
    }
    
    func testSetContentToNil() {
        testObject.content = nil
        XCTAssertNil(testObject.content)
        XCTAssertTrue(testObject.titleField?.text == "")
        XCTAssertTrue(testObject.priceField?.text == "")
    }
    
    func testSetContentToWrongObjectClass() {
        testObject.content = Date()
        XCTAssertNotNil(testObject.content)
        XCTAssertTrue(testObject.titleField?.text == "Wrong object class")
        XCTAssertTrue(testObject.priceField?.text == "")
    }
    
    func testSetContentToFruit() {
        testObject.content = Fruit(name: "Strawberry", category: .berry, price: 22.0)
        XCTAssertNotNil(testObject.content)
        XCTAssertTrue(testObject.titleField?.text == "Strawberry", "textLabel should be : Strawberry - is \((testObject.titleField?.text)!)")
        XCTAssertTrue(testObject.priceField?.text == "\(22.0)", "textLabel should be : 22.0 - is \((testObject.priceField?.text)!)")
    }
    
    func testTextFieldShouldBeginEditing(){
        let textField = UITextField()
        let result = self.testObject.textFieldShouldBeginEditing(textField)
        XCTAssertTrue(result)
        XCTAssertTrue(self.didCall_editableFruitTableViewCellBeginEditing)
        XCTAssertFalse(self.didCall_editableFruitTableViewCellRequestUniqueNames)
        XCTAssertFalse(self.didCall_editableFruitTableViewCellValueDidChange)
        XCTAssertTrue(textField.textColor == UIColor.blue)
        XCTAssertTrue(textField.backgroundColor == UIColor.white)
    }
    
    func testTextFieldShouldEndEditing(){
        let textField = UITextField()
        let result = self.testObject.textFieldShouldEndEditing(textField)
        XCTAssertTrue(result)
        XCTAssertFalse(self.didCall_editableFruitTableViewCellBeginEditing)
        XCTAssertFalse(self.didCall_editableFruitTableViewCellRequestUniqueNames)
        XCTAssertFalse(self.didCall_editableFruitTableViewCellValueDidChange)
        XCTAssertTrue(textField.textColor == UIColor.black)
        XCTAssertTrue(textField.backgroundColor == UIColor.white)

    }
    
    func testSetNoEditing() {
        let textField = UITextField()
        
        testObject.setNoEditing(textField: textField)
        
        XCTAssertTrue(textField.textColor == UIColor.black)
        XCTAssertTrue(textField.backgroundColor == UIColor.white)
    }
    
    func testSetEditing() {
        let textField = UITextField()
        
        testObject.setEditing(textField: textField)
        
        XCTAssertTrue(textField.textColor == UIColor.blue)
        XCTAssertTrue(textField.backgroundColor == UIColor.white)
    }
    
    
    func testShouldChangeCharactersInRange_Price_Valid(){
        
        testObject.priceField.text = "10.0"
        let fruit = Fruit(name: "Raspberry")
        testObject.content = fruit
        let testRange = NSRange(location: 4, length: 0)
        XCTAssertTrue(testObject.textField(testObject.priceField, shouldChangeCharactersIn: testRange, replacementString: "1"))
    }
  
    func testShouldChangeCharactersInRange_Price_Invalid(){
        testObject.priceField.text = "10.0"
        let fruit = Fruit(name: "Raspberry")
        testObject.content = fruit
        let testRange = NSRange(location: 4, length: 0)
        XCTAssertFalse(testObject.textField(testObject.priceField, shouldChangeCharactersIn: testRange, replacementString: "A"))
    }
    
    func testShouldChangeCharactersInRange_Name_Valid(){
        testObject.titleField.text = "Raspberry"
        let fruit = Fruit(name: "Raspberry")
        testObject.content = fruit
        self.value_UniqueValues = ["Raspberry2"]

        let testRange = NSRange(location: 9, length: 0)
        XCTAssertTrue(testObject.textField(testObject.titleField, shouldChangeCharactersIn: testRange, replacementString: "1"))

    }
    
    func testShouldChangeCharactersInRange_Name_Invalid(){
        testObject.titleField.text = "Raspberry"
        let fruit = Fruit(name: "Raspberry")
        testObject.content = fruit
        self.value_UniqueValues = ["Raspberry2"]
        
        let testRange = NSRange(location: 9, length: 0)
        XCTAssertFalse(testObject.textField(testObject.titleField, shouldChangeCharactersIn: testRange, replacementString: "2"))
     }

    
    func testValidatePriceField_noValidator(){
        let textField = UITextField()
        testObject.priceValidator = nil
        
        XCTAssertTrue(testObject.validatePriceField(textField: textField, newString: "20.0"))
        XCTAssertFalse(didCall_editableFruitTableViewCellValueDidChange)
    }
    
    func testValidatePriceField_Valid_Number(){
        let textField = UITextField()
        let fruit = Fruit(name: "Raspberry")
        testObject.content = fruit

        XCTAssertTrue(testObject.validatePriceField(textField: textField, newString: "20.0"))
        XCTAssertTrue(didCall_editableFruitTableViewCellValueDidChange)

    }
    
    func testValidatePriceField_Valid_EmptyString(){
        let textField = UITextField()
        let fruit = Fruit(name: "Raspberry")
        testObject.content = fruit
        
        XCTAssertTrue(testObject.validatePriceField(textField: textField, newString: ""))
        XCTAssertTrue(didCall_editableFruitTableViewCellValueDidChange)

    }
    
    func testValidatePriceField_Invalid_Spaces(){
        let textField = UITextField()
        let fruit = Fruit(name: "Raspberry")
        testObject.content = fruit
        
        XCTAssertFalse(testObject.validatePriceField(textField: textField, newString: "   "))
        XCTAssertFalse(didCall_editableFruitTableViewCellValueDidChange)
        
    }
    
    func testValidatePriceField_Invalid(){
        let textField = UITextField()
        let fruit = Fruit(name: "Raspberry")
        testObject.content = fruit
        
        XCTAssertFalse(testObject.validatePriceField(textField: textField, newString: "Ax7B4"))
        XCTAssertFalse(didCall_editableFruitTableViewCellValueDidChange)

    }
    
    
    func testValidateNameField_noDelegate(){
        let textField = UITextField()
        testObject.delegate = nil
        
        XCTAssertTrue(testObject.validateNameField(textField: textField, newString: "Raspberry"))
        XCTAssertFalse(didCall_editableFruitTableViewCellValueDidChange)
   }
    
    func testValidateNameField_noValidator(){
        let textField = UITextField()
        testObject.titleValidator = nil
        
        XCTAssertTrue(testObject.validateNameField(textField: textField, newString: "Raspberry"))
        XCTAssertFalse(didCall_editableFruitTableViewCellValueDidChange)
  }
    
    func testValidateNameField_Valid(){
        let textField = UITextField()
        let fruit = Fruit(name: "Raspberry")
        testObject.content = fruit
  
        XCTAssertTrue(testObject.validateNameField(textField: textField, newString: "Raspberry"))
        XCTAssertTrue(didCall_editableFruitTableViewCellValueDidChange)
    }
    
    func testValidateNameField_Invalid(){
        let textField = UITextField()
        let fruit = Fruit(name: "Raspberry")
        testObject.content = fruit
        self.value_UniqueValues = ["Raspberry"]
        XCTAssertFalse(testObject.validateNameField(textField: textField, newString: "Raspberry"))
        XCTAssertFalse(didCall_editableFruitTableViewCellValueDidChange)
    }
    
    
    func testReplaceInString_newString(){
        let testRange = NSRange(location: 9, length: 0)

        let result = testObject.replaceInString("Raspberry", range: testRange, replacementString: "1")
        
        XCTAssertTrue(result == "Raspberry1")
    }
    
  
}

extension EditableFruitTableViewCellTests : EditableFruitTableViewCellDelegate {
    func editableFruitTableViewCellBeginEditing(_ cell: EditableFruitTableViewCell) {
        didCall_editableFruitTableViewCellBeginEditing = true
    }
    
    func editableFruitTableViewCellValueDidChange(_ cell: EditableFruitTableViewCell, value: Any?) {
        didCall_editableFruitTableViewCellValueDidChange = true
    }
    
    func editableFruitTableViewCellRequestUniqueNames(for section: Int) -> [String] {
        didCall_editableFruitTableViewCellRequestUniqueNames = true
        return value_UniqueValues
    }
    
    
}
