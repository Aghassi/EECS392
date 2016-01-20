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
        if checkAllFieldsFilled() {
            let property = Property()
            property.name = nameTextField.text!
            property.address = addressTextField.text!
            property.propertyData = purchaseDataTextField.text!
            property.price = Double(purchasePriceTextField.text!)!
            property.owner = ownersNameTextField.text!
        }
        else {
            print("Please fill in all fields")
        }
    }
    
    /**
     Checks all the text fields are filled
    */
    func checkAllFieldsFilled() -> Bool {
        for field in fields {
            if field.text!.isEmpty {
                return false
            }
        }
        
        return true
    }
}

