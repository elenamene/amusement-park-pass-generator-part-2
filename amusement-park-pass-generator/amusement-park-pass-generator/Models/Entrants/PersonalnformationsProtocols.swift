//
//  PersonalInfoProtocols.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 19/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

// MARK: - Nameable

protocol Nameable {
    var firstName: String { get }
    var lastName: String { get }
}

// MARK: - Addressable

struct Address {
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
}

protocol Addressable {
    var address: Address { get }
}

// MARK: - Ageable

protocol Ageable {
    var dateOfBirth: Date? { get }
}

extension Ageable {
    func isTodayBirthday() -> Bool {
        if let dateOfBirth = self.dateOfBirth, dateOfBirth.isSameDayAndMonthOfToday() {
            return true
        } else {
            return false
        }
    }
}

// MARK: - SSNIdentifiable

protocol SSNIdentifiable {
    var socialSecurityNumber: String { get }
}

// MARK: - ProjectIdentifiable

protocol ProjectIdentifiable {
    var projectNumber: ProjectNumber { get }
}

// MARK: - VendorTrackable

protocol VendorTrackable {
    var company: VendorCompany { get }
    var dateOfVisit: Date { get set }
}
