//
//  Vendor.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 28/03/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

enum VendorCompany: String {
    case acme = "Acme"
    case orkin = "Orkin"
    case fedex = "Fedex"
    case nwElectrical = "NW Electrical"
}

class Vendor: Nameable, Ageable, VendorTrackable {
    var firstName: String
    var lastName: String
    var dateOfBirth: Date?
    var company: VendorCompany
    var dateOfVisit: Date
    var accessPass: Pass?
    
    init(firstName: String, lastName: String, dateOfBirth: String, company: String, dateOfVisit: String) throws {
        self.firstName = try FormValidation.firstName(firstName)
        self.lastName = try FormValidation.lastName(lastName)
        self.dateOfBirth = try FormValidation.date(dateOfBirth)
        self.company = try FormValidation.companyName(company)
        self.dateOfVisit = try FormValidation.date(dateOfVisit)
    }
}

extension Vendor: Entrant {
    var entrantType: EntrantType {
        return .vendor
    }
    
    var areasPermitted: [ParkArea] {
        switch company {
        case .acme: return [.kitchen]
        case .orkin: return [.amusement, .rideControl, .kitchen]
        case .fedex: return [.maintenance, .office]
        case .nwElectrical: return [.amusement, .rideControl, .kitchen, .maintenance, .office]
        }
    }
}
