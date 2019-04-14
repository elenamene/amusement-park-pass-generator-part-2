//
//  EntrantError.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 21/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

enum FormError: String, Error {
    case invalidFirstName = "Please insert your first name."
    case invalidLastName = "Please insert your last name."
    case invalidStreetAddress = "Please insert your address."
    case invalidCity = "Please insert your City."
    case invalidState = "Please insert your State."
    case invalidZipCode = "Please insert your Zip Code."
    case invalidDateOfBirth = "Please insert your date of birth."
    case invalidSocialSecurityNumber = "Please insert your Social Security Number."
    case invalidAge = "Free child guest must be under 5 years old. Please select Classic Guest."
    case invalidProjectNumber = "Please insert a valid project number"
    case invalidVendorCompany = "Please insert a valid company name"
}

struct FormValidation {
    static let zipRegex = "(^[0-9]{5}(-[87)?$)"
    static let streetRegex = #"\d{1,4} [\w\s]{1,20}(?:street|st|avenue|ave|road|rd|highway|hwy|lane|square|sq|trail|trl|drive|dr|court|ct|park|parkway|pkwy|circle|cir|boulevard|blvd)\W?"#
    static let ssnRegex = "^\\d{3}-\\d{2}-\\d{4}$"

    
    static func firstName(_ input: String) throws -> String {
        guard input.isLengthEqualOrGreaterThan(3) else {
            throw FormError.invalidFirstName
        }
        
        return input
    }
    
    static func lastName(_ input: String) throws -> String {
        guard input.isLengthEqualOrGreaterThan(3) else {
            throw FormError.invalidLastName
        }
        
        return input
    }

    static func address(_ address: Address) throws -> Address {
        guard address.city.isLengthEqualOrGreaterThan(3) else {
            throw FormError.invalidCity
        }
        guard address.state.isLengthEqualOrGreaterThan(3) else {
            throw FormError.invalidState
        }
        guard address.streetAddress.isValidFormat(regex: streetRegex) else {
            throw FormError.invalidStreetAddress
        }
        guard address.zipCode.isValidFormat(regex: zipRegex) else {
            throw FormError.invalidZipCode
        }

        return Address(streetAddress: address.streetAddress, city: address.city, state: address.state, zipCode: address.zipCode)
    }
    
    static func date(_ input: String) throws -> Date {
        guard let date = input.getDate else {
            throw FormError.invalidDateOfBirth
        }
        return date
    }
    
    
    static func ssn(_ input: String) throws -> String {
        guard input.isValidFormat(regex: ssnRegex) else {
            throw FormError.invalidSocialSecurityNumber
        }
        
        return input
    }
       
    static func projectNumber(_ input: String) throws -> ProjectNumber {
        guard let number = Int(input), let projectNumber = ProjectNumber(rawValue: number) else {
            throw FormError.invalidProjectNumber
        }
        
        return projectNumber
    }

    static func companyName(_ input: String) throws -> VendorCompany {
        guard let name = VendorCompany(rawValue: input.lowercased()) else {
            throw FormError.invalidProjectNumber
        }
        
        return name
    }
}
