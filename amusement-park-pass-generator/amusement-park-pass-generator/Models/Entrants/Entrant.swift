//
//  Entrant.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 19/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import UIKit

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
    
    func color() -> UIColor {
        switch self {
        case .pass: return UIColor.myGreen
        case .fail: return UIColor.myRed
        }
    }
    
    func soundName() -> (String) {
        switch self {
        case .pass: return "AccessGranted"
        case .fail: return "AccessDenied"
        }
    }
}

extension Entrant {
    func swipePass(atRestrictedArea area: ParkArea) -> (validation: AccessValidation, isBirthday: Bool?) {
        let isBirthday: Bool
        let validation: AccessValidation
        
        // Check for birthday
        if let entrant = self as? Ageable, entrant.isTodayBirthday() {
            isBirthday = true
        } else {
            isBirthday = false
        }
        
        // Check for access permission
        if let pass = self.accessPass, pass.areasPermitted.contains(area) {
           validation = .pass
        } else {
            validation = .fail
        }
        
        return (validation, isBirthday)
    }
    
    func swipePassAtRide(accessType: RideAccess) throws -> (validation: AccessValidation, isBirthday: Bool?) {
        let isBirthday: Bool
        let validation: AccessValidation
        
        // Check for birthday
        if let entrant = self as? Ageable, entrant.isTodayBirthday() {
            isBirthday = true
        } else {
            isBirthday = false
        }
     
        // Check for double swiping
        if SwipeTracker.hasEntrantSwipedDouble(entrant: self) {
            throw SwipeError.doubleSwiping
        }
        
        // Check for access ride priviledges
        if let pass = self.accessPass, pass.rideAccess.contains(accessType) {
            validation = .pass
        } else {
            validation = .fail
        }
        
         return (validation, isBirthday)
    }
    
    func swipePassAtCashRegister() -> (validation: AccessValidation, isBirthday: Bool?) {
        let isBirthday: Bool
        let validation: AccessValidation
        
        // Check for birthday
        if let entrant = self as? Ageable, entrant.isTodayBirthday() {
            isBirthday = true
        } else {
            isBirthday = false
        }
        
        // Check for discounts
        if let pass = self.accessPass, pass.discount.food == 0 && pass.discount.merchandise == 0 {
            validation = .fail
        } else {
            validation = .pass
        }
        
        return (validation, isBirthday)
    }
}

