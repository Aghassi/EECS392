//
//  ViewController.swift
//  Property
//
//  Created by David Aghassi on 1/19/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // MARK: Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var purchaseDateTextField: UITextField!
    @IBOutlet weak var purchasePriceTextField: UITextField!
    @IBOutlet weak var ownersNameTextField: UITextField!
    
    // MARK: Buttons
    @IBAction func purchaseDateField(sender: UITextField) {
        
    }
    @IBAction func purchaseButton(sender: UIButton) {
        purchase()
    }
    
    // Used to house the fields so we can search over them
    var fields: [UITextField] = []
    
    override func viewDidLoad() {
        fields = [nameTextField, addressTextField, purchaseDateTextField, purchasePriceTextField, ownersNameTextField]
        
        // Create and set a date picker for the date field
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .Date
        purchaseDateTextField.inputView = datePicker
        datePicker.addTarget(self, action: "handleDatePicker:", forControlEvents: .ValueChanged)
    }
    
    /**
     Handles the input from the date picker, and formats it for the text field
     
     - parameter sender: A UIDatePicker that is being dismissed after a `.ValueChanged` event
    */
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormat = NSDateFormatter()
        dateFormat.dateStyle = .ShortStyle
        dateFormat.timeStyle = .NoStyle
        purchaseDateTextField.text = dateFormat.stringFromDate(sender.date)
    }
    

    // MARK: UITextFieldDelegates
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Depending on the text field, we set it to the next textfield
        switch textField {
        case let x where x == nameTextField:
            addressTextField.becomeFirstResponder()
        case let x where x == addressTextField:
            purchaseDateTextField.becomeFirstResponder()
        case let x where x == purchaseDateTextField:
            purchasePriceTextField.becomeFirstResponder()
        case let x where x == purchasePriceTextField:
            ownersNameTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        textField.inputAccessoryView = appendAccessoryButtonToKeyboard()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        purchase()
    }
    
    /**
     Creates a "Done" `UIBarButtonItem` in a `UIToolBar` to be returned
     
     - returns: A `UIToolBar` that contains flex space and a done button
    */
    func appendAccessoryButtonToKeyboard() -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRectMake(0,0, view.bounds.width, 50))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        let namedButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "dismissKeyboard:")
        
        let toolbarArray = [flexSpace, namedButton]
        toolBar.items = toolbarArray
        toolBar.sizeToFit()
        return toolBar
    }
    
    /**
     Dismisses the current first responder and ends editing
     
     - parameter sender: `AnyObject` that is calling this function
    */
    func dismissKeyboard(sender: AnyObject) {
        for field in fields {
            if field.isFirstResponder() {
                field.endEditing(true)
                field.resignFirstResponder()
            }
        }
    }
    
    // MARK: Helper functions
    /**
     Checks if all the fields are filled, and will create a new property object if they are. Otherwise, it prints `"Please fill in all fields"` to the console
    */
    func purchase() {
        if allFieldsFilled() {
            createData()
        }
        else {
            print("Please fill in all fields")
        }
        
    }
    
    /**
     Checks all the text fields are filled
     
     - returns: `true` if all the text fields are no empty
    */
    func allFieldsFilled() -> Bool {
        for field in fields {
            if field.text!.isEmpty {
                return false
            }
        }
        
        return true
    }
    
    /**
     Takes the properties from the textfield outlets and assigns them to a new `Property` object and prints them to the console.
    */
    func createData() {
        let property = Property()
        property.name = nameTextField.text!
        property.address = addressTextField.text!
        property.propertyDate = purchaseDateTextField.text!
        property.price = Double(purchasePriceTextField.text!)!
        property.owner = ownersNameTextField.text!
        print("The property \(property.name) at \(property.address) will be purchased for \(property.price) from the owner \(property.owner) ")
    }
}

