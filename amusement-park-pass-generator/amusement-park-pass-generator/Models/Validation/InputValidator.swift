//
//  InputValidator.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 29/03/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

enum Validation {
    case success
    case failure
}

//  message : String = "Must be at least 3 characters long"
// Please provide a valid firstName
// message: 'The US zip code must contain 5 digits'
// (^[0-9]{5}(-[0-9]{4})?$)
// NNNNN-NNNN

struct InputValidator {
    // Check if name is at least 3 characters long
    func isNameValidLength(_ name: String) -> Bool {
        let minLength = 3
        
        return name.count >= minLength
    }
    
    // Check if is valid US street address
    func isStreetAddressValid(_ streetAddress: String) -> Bool {
        let regex = #"\d{1,4} [\w\s]{1,20}(?:street|st|avenue|ave|road|rd|highway|hwy|lane|square|sq|trail|trl|drive|dr|court|ct|park|parkway|pkwy|circle|cir|boulevard|blvd)\W?"#
        
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: streetAddress.lowercased())
    }
    
    // Check if zip code is US format NNNNN-NNNN
    func isZipCodeValid(_ zipCode: String) -> Bool {
        let regex = "(^[0-9]{5}(-[87)?$)"
        
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: zipCode.uppercased())
    }
    
    // Check if date is of the correct format (MM/DD/YYYY)
    func isDateFormatValid(_ date: String) -> Bool {
        let validDateFormat = "MM/dd/yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = validDateFormat
        
        return dateFormatter.date(from: date) != nil
    }
    
    // Check if SSN format is NNN-NN-NNNN
    func isSSNValid(_ number: String) -> Bool {
        let regex = "^\\d{3}-\\d{2}-\\d{4}$"
        
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: number.uppercased())
    }
}
