//
//  EntrantError.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 21/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

enum EntrantError: String, Error {
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
    static let validator = InputValidator()
    
    static func firstName(_ input: String) throws -> String {
        guard validator.isNameValidLength(input) else {
            throw EntrantError.invalidFirstName
        }
        
        return input
    }
    
    static func lastName(_ input: String) throws -> String {
        guard validator.isNameValidLength(input) else {
            throw EntrantError.invalidLastName
        }
        
        return input
    }

    static func address(_ address: Address) throws -> Address {
        guard validator.isNameValidLength(address.city) else {
            throw EntrantError.invalidCity
        }
        guard validator.isNameValidLength(address.state) else {
            throw EntrantError.invalidState
        }
        guard validator.isStreetAddressValid(address.streetAddress) else {
            throw EntrantError.invalidStreetAddress
        }
        guard validator.isZipCodeValid(address.zipCode) else {
            throw EntrantError.invalidZipCode
        }

        return Address(streetAddress: address.streetAddress, city: address.city, state: address.state, zipCode: address.zipCode)
    }
    
    static func date(_ input: String) throws -> Date {
        guard validator.isDateFormatValid(input), let date = input.getDate else {
            throw EntrantError.invalidDateOfBirth
        }
        
        return date
    }
    
    
    static func ssn(_ input: String) throws -> String {
        guard validator.isSSNValid(input) else {
            throw EntrantError.invalidSocialSecurityNumber
        }
        
        return input
    }
       
    static func projectNumber(_ input: String) throws -> ProjectNumber {
        guard let number = Int(input), let projectNumber = ProjectNumber(rawValue: number) else {
            throw EntrantError.invalidProjectNumber
        }
        
        return projectNumber
    }

    static func companyName(_ input: String) throws -> VendorCompany {
        guard let name = VendorCompany(rawValue: input.lowercased()) else {
            throw EntrantError.invalidProjectNumber
        }
        
        return name
    }
}
