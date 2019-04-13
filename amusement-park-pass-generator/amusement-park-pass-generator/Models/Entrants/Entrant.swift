//
//  Entrant.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 19/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

// MARK: - EntrantType

enum EntrantType: String {
    case classicGuest = "Classic Guest"
    case vipGuest = "VIP Guest"
    case freeChildGuest = "Free Child Guest"
    case seasonPassGuest = "Season Pass Guest"
    case seniorGuest = "Senior Guest"
    case hourlyEmployeeFoodServices = "Hourly Employee - Food Services"
    case hourlyEmployeeRideServices = "Hourly Employee - Ride Services"
    case hourlyEmployeeMaintenance = "Hourly Employee - Maintenance"
    case shiftManager = "Shift Manager"
    case generalManager = "General Manager"
    case seniorManager = "Senior Manager"
    case contractor  = "Contractor"
    case vendor = "Vendor"
}

// MARK: - Entrant

protocol Entrant {
    var entrantType: EntrantType { get }
    var accessPass: Pass? { get set }
    var areasPermitted: [ParkArea] { get }
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
        if SwipeTracker.hasEntrantSwipedDouble(entrant: self) {
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

