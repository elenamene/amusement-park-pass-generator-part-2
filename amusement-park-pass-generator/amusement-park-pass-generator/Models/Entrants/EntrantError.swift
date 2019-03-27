//
//  EntrantError.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 21/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

enum EntrantError: String, Error {
    case invalidFirstName = "Please insert your first name."
    case invalidLastName = "Please insert your last name."
    case invalidStreetAddress = "Please insert your Address."
    case invalidCity = "Please insert your City."
    case invalidState = "Please insert your State."
    case invalidZipCode = "Please insert your Zip Code."
    case invalidDateOfBirth = "Please insert your date of birth."
    case invalidSocialSecurityNumber = "Please insert your Social Security Number."
    case invalidAge = "Free child guest must be under 5 years old. Please select Classic Guest."
}
