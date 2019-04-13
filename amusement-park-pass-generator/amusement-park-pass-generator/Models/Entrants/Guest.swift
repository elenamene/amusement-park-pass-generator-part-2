//
//  Guest.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 19/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

// MARK: - Protocol Guest

enum GuestType: String, CaseIterable {
    case classic = "Classic"
    case vip = "VIP"
    case freeChild = "Free Child"
    case seasonPass = "Season Pass"
    case senior = "Senior"
}

protocol Guest: Entrant {
}

extension Guest {
    var areasPermitted: [ParkArea] {
        return [.amusement]
    }
}

// MARK: - Guest Classes

class ClassicGuest: Guest {
    var entrantType: EntrantType = .classicGuest
    var accessPass: Pass?
    
}

class VIPGuest: Guest {
    var entrantType: EntrantType = .vipGuest
//    var type: GuestType = .vip // do I need this?
    var accessPass: Pass?
}

class FreeChildGuest: Guest, Ageable {
    var entrantType: EntrantType = .freeChildGuest
//    var type: GuestType = .freeChild // do I need this?
    var dateOfBirth: Date?
    var accessPass: Pass?
    
    init(dateOfBirth: String) throws {
        self.dateOfBirth = try FormValidation.date(dateOfBirth)
        
        if let age = self.dateOfBirth?.age {
            if age >= 5 {
                throw EntrantError.invalidAge
            }
        }
    }
}

class SeasonPassGuest: Guest, Nameable, Addressable, Ageable {
    var entrantType: EntrantType = .seasonPassGuest
//    var type: GuestType = .seasonPass
    var firstName: String
    var lastName: String
    var address: Address
    var dateOfBirth: Date?
    var accessPass: Pass?
    
    init(firstName: String, lastName: String, address: Address, dateOfBirth: String) throws {
        self.firstName = try FormValidation.firstName(firstName)
        self.lastName = try FormValidation.lastName(lastName)
        self.address = try FormValidation.address(address)
        self.dateOfBirth = try FormValidation.date(dateOfBirth)
    }
}

class SeniorGuest: Guest, Nameable, Ageable {
    var entrantType: EntrantType = .seniorGuest
    var firstName: String
    var lastName: String
    var dateOfBirth: Date?
    var accessPass: Pass?
    
    init(firstName: String, lastName: String, dateOfBirth: String) throws {
        self.firstName = try FormValidation.firstName(firstName)
        self.lastName = try FormValidation.lastName(lastName)
        self.dateOfBirth = try FormValidation.date(dateOfBirth)
    }
}


