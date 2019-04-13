//
//  Employee.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 19/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

// MARK: - Employee

typealias Employee = Nameable & Addressable & Ageable & SSNIdentifiable

// MARK: - HourlyEmployeeType

enum ServiceType: String, CaseIterable {
    case foodServices = "Food Services"
    case rideServices = "Ride Services"
    case maintenance = "Maintenance"
}

class HourlyEmployee: Employee {
    var firstName: String
    var lastName: String
    var address: Address
    var dateOfBirth: Date?
    var socialSecurityNumber: String
    var service: ServiceType
    var accessPass: Pass?
    
    init(firstName: String, lastName: String, address: Address, dateOfBirth: String, socialSecurityNumber: String, service: ServiceType) throws {
        self.firstName = try FormValidation.firstName(firstName)
        self.lastName = try FormValidation.lastName(lastName)
        self.address = try FormValidation.address(address)
        self.dateOfBirth = try FormValidation.date(dateOfBirth)
        self.socialSecurityNumber = try FormValidation.ssn(socialSecurityNumber)
        self.service = service
    }
}

extension HourlyEmployee: Entrant {
    var entrantType: EntrantType {
        switch service {
        case .foodServices : return .hourlyEmployeeFoodServices
        case .rideServices: return .hourlyEmployeeRideServices
        case .maintenance: return .hourlyEmployeeMaintenance
        }
    }
    
    var areasPermitted: [ParkArea] {
        switch service {
        case .foodServices : return [.amusement, .kitchen]
        case .rideServices: return [.amusement, .rideControl]
        case .maintenance: return [.amusement, .kitchen, .rideControl, .maintenance]
        }
    }
}


// MARK: - Manager

enum ManagerTier: String, CaseIterable {
    case shift = "Shift Manager"
    case general = "General Manager"
    case senior = "Senior Manager"
}

class Manager: Employee {
    var firstName: String
    var lastName: String
    var address: Address
    var dateOfBirth: Date?
    var socialSecurityNumber: String
    var accessPass: Pass?
    var tier: ManagerTier
    
    init(firstName: String, lastName: String, address: Address, dateOfBirth: String, socialSecurityNumber: String, tier: ManagerTier) throws {
        self.firstName = try FormValidation.firstName(firstName)
        self.lastName = try FormValidation.lastName(lastName)
        self.address = try FormValidation.address(address)
        self.dateOfBirth = try FormValidation.date(dateOfBirth)
        self.socialSecurityNumber = try FormValidation.ssn(socialSecurityNumber)
        self.tier = tier
    }
}

extension Manager: Entrant {
    var entrantType: EntrantType {
        switch tier {
        case .shift: return .shiftManager
        case .general: return .generalManager
        case .senior: return .seniorManager
        }
    }
    
    var areasPermitted: [ParkArea] {
        return [.amusement, .kitchen, .rideControl, .maintenance, .office]
    }
}

// MARK: - Contract Employee

enum ProjectNumber: Int, CaseIterable {
    case p1 = 1001
    case p2 = 1002
    case p3 = 1003
    case p4 = 2001
    case p5 = 2002
}

class Contractor: Employee, ProjectIdentifiable {
    var firstName: String
    var lastName: String
    var address: Address
    var dateOfBirth: Date?
    var socialSecurityNumber: String
    var projectNumber: ProjectNumber
    var accessPass: Pass?
    
    init(firstName: String, lastName: String, address: Address, dateOfBirth: String, socialSecurityNumber: String, projectNumber: String) throws {
        self.firstName = try FormValidation.firstName(firstName)
        self.lastName = try FormValidation.lastName(lastName)
        self.address = try FormValidation.address(address)
        self.dateOfBirth = try FormValidation.date(dateOfBirth)
        self.socialSecurityNumber = try FormValidation.ssn(socialSecurityNumber)
        self.projectNumber = try FormValidation.projectNumber(projectNumber)
    }
}

extension Contractor: Entrant {
    var entrantType: EntrantType {
        return .contractor
    }
    
    var areasPermitted: [ParkArea] {
        switch projectNumber {
        case .p1: return [.amusement, .rideControl]
        case .p2: return [.amusement, .rideControl, .maintenance]
        case .p3: return [.amusement, .rideControl, .kitchen, .maintenance, .office]
        case .p4: return [.office]
        case .p5: return [.kitchen, .maintenance]
        }
    }
}
