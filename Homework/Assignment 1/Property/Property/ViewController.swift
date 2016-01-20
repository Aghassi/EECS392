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
    @IBOutlet weak var purchaseDataTextField: UITextField!
    @IBOutlet weak var purchasePriceTextField: UITextField!
    @IBOutlet weak var ownersNameTextField: UITextField!
    
    // MARK: Buttons
    @IBAction func purchaseButton(sender: UIButton) {
        purchase()
    }
    
    // Used to house the fields so we can search over them
    var fields: [UITextField] = []
    
    override func viewDidLoad() {
        fields = [nameTextField, addressTextField, purchaseDataTextField, purchasePriceTextField, ownersNameTextField]
    }

    // MARK: UITextFieldDelegates
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Depending on the text field, we set it to the next textfield
        switch textField {
        case let x where x == nameTextField:
            addressTextField.becomeFirstResponder()
        case let x where x == addressTextField:
            purchaseDataTextField.becomeFirstResponder()
        case let x where x == purchaseDataTextField:
            purchasePriceTextField.becomeFirstResponder()
        case let x where x == purchasePriceTextField:
            ownersNameTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        purchase()
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
        property.propertyData = purchaseDataTextField.text!
        property.price = Double(purchasePriceTextField.text!)!
        property.owner = ownersNameTextField.text!
        print("The property \(property.name) at \(property.address) will be purchased for \(property.price) from the owner \(property.owner) ")
    }
}

