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
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var purchaseDateTextField: UITextField!
    @IBOutlet weak var purchasePriceTextField: UITextField!
    @IBOutlet weak var ownersNameTextField: UITextField!
    
    // List of states for stateTextField
    let state = [ "AK",
        "AL",
        "AR",
        "AS",
        "AZ",
        "CA",
        "CO",
        "CT",
        "DC",
        "DE",
        "FL",
        "GA",
        "GU",
        "HI",
        "IA",
        "ID",
        "IL",
        "IN",
        "KS",
        "KY",
        "LA",
        "MA",
        "MD",
        "ME",
        "MI",
        "MN",
        "MO",
        "MS",
        "MT",
        "NC",
        "ND",
        "NE",
        "NH",
        "NJ",
        "NM",
        "NV",
        "NY",
        "OH",
        "OK",
        "OR",
        "PA",
        "PR",
        "RI",
        "SC",
        "SD",
        "TN",
        "TX",
        "UT",
        "VA",
        "VI",
        "VT",
        "WA",
        "WI",
        "WV",
        "WY"]
    
    var countries: [String] = []
    
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
        
        // Populate countries
        for code in NSLocale.ISOCountryCodes() as [String] {
            let id = NSLocale.localeIdentifierFromComponents([NSLocaleCountryCode: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayNameForKey(NSLocaleIdentifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
        
        // Create and set a date picker for the date field
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .Date
        
        let statePicker = UIPickerView()
        statePicker.dataSource = self
        statePicker.delegate = self
        
        let countryPicker = UIPickerView()
        countryPicker.dataSource = self
        countryPicker.delegate = self
        
        
        stateTextField.inputView = statePicker
        countryTextField.inputView = countryPicker
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
        print("The property \(property.name) at \(property.address) will be purchased for \(property.price) from the owner \(property.owner) on \(property.propertyDate) ")
    }
}

// MARK: UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView  == stateTextField.inputView as! UIPickerView {
            return state.count
        }
        else if pickerView == countryTextField.inputView as! UIPickerView {
            return countries.count
        }
        else {
            return 0
        }
    }
}

// MARK: UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView  == stateTextField.inputView as! UIPickerView {
            return state[row]
        }
        else if pickerView == countryTextField.inputView as! UIPickerView {
            return countries[row]
        }
        else {
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView  == stateTextField.inputView as! UIPickerView {
            stateTextField.text = state[row]
        }
        else if pickerView == countryTextField.inputView as! UIPickerView {
            countryTextField.text = countries[row]
        }
    }
}
