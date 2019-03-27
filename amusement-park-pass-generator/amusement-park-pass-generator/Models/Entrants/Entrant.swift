//
//  Entrant.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 19/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

// MARK: - Entrant

enum EntrantType: String {
    case classicGuest = "Classic Guest"
    case vipGuest = "VIP Guest"
    case freeChildGuest = "Free Child Guest"
    case hourlyEmployeeFoodServices = "Hourly Employee - Food Services"
    case hourlyEmployeeRideServices = "Hourly Employee - Ride Services"
    case hourlyEmployeeMaintenance = "Hourly Employee - Maintenance"
    case manager = "Manager"
}

protocol Entrant {
    var entrantType: EntrantType { get }
    var accessPass: Pass? { get set }
}

// MARK: - Entrant Validation

extension Entrant {
    func isValidEntrant() -> Bool {
        do {
            if let entrant = self as? Nameable {
                try entrant.hasValidName()
            }
            if let entrant = self as? Addressable {
                try entrant.hasValidAddress()
            }
            if let entrant = self as? Ageable {
                try entrant.hasValidDateOfBirth()
            }
            if let entrant = self as? SSNIdentifiable {
                try entrant.hasValidSSN()
            }
        } catch let error as EntrantError {
            print(error.rawValue)
            return false
        } catch {
            fatalError("Unexpected error: \(error).")
        }
        
        return true
    }
}

// MARK: - Entrant Swipe Methods

enum AccessValidation: String {
    case pass = "Access Permitted"
    case fail = "Access Denied"
}

extension Entrant {
    func swipePass(atRestrictedArea area: ParkArea) -> AccessValidation {
        
        // Check for birthday
        if let entrant = self as? Ageable, entrant.isTodayBirthday() {
            print(Message.happyBirthday(entrant).text)
        }
        
        // Check for access permission
        if let pass = self.accessPass, pass.areasPermitted.contains(area) {
            print(AccessValidation.pass.rawValue)
            return AccessValidation.pass
        } else {
            print(AccessValidation.fail.rawValue)
            return AccessValidation.fail
        }
    }
    
    func swipePassAtRide() -> [RideAccess]? {
        guard let pass = self.accessPass else { return nil }
        
        // Check for birthday
        if let entrant = self as? Ageable, entrant.isTodayBirthday() {
            print(Message.happyBirthday(entrant).text)
        }
        
        // Check for double swiping
        if SwipeController.hasEntrantSwipedDouble(entrant: self) {
            print(Message.doubleSwiping(self).text)
            return nil
        }
        
        print("Ride access: \(pass.rideAccess.map { $0.rawValue })")
        
        return pass.rideAccess
    }
    
    func swipePassAtCashRegister() {
        guard let pass = self.accessPass else { return }
        
        // Check for birthday
        if let entrant = self as? Ageable, entrant.isTodayBirthday() {
            print(Message.happyBirthday(entrant).text)
        }
        
        print(pass.discount.description)
    }
}

