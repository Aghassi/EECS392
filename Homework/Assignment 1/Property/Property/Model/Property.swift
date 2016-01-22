//
//  Property.swift
//  Property
//
//  Created by David Aghassi on 1/20/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import Foundation

class Property {
    // MARK: Properties
    var name: String = ""
    var address: String = ""
    var propertyDate: String = ""
    var price: Double! = 0.0
    var owner: String = ""
    
    // Need to override init? Seems like a bit much when all
    // the properties can be set after instantiation
}