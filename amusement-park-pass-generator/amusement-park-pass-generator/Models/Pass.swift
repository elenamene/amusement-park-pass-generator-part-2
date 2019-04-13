//
//  Pass.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 19/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

class Pass {
    let passHolder: Entrant
    var lastSwipe: Date?
    
    init(for entrant: Entrant) {
        self.passHolder = entrant
    }
}

extension Pass {
    var areasPermitted: [ParkArea] {
        return passHolder.areasPermitted
    }
    
    var rideAccess: [RideAccess] {
        switch passHolder {
        case is VIPGuest: return [.accessAllRides, .skipAllRidesLines]
        case is Vendor, is Contractor: return []
        default: return [.accessAllRides]
        }
    }
    
    var discount: Discount {
        switch self.passHolder {
        case is VIPGuest: return Discount(onFood: 10, onMerchandise: 20)
        case is HourlyEmployee: return Discount(onFood: 15, onMerchandise: 25)
        case is Manager: return Discount(onFood: 25, onMerchandise: 25)
        default: return Discount(onFood: 0, onMerchandise: 0)
        }
    }
}

extension Pass: CustomStringConvertible {
    var description: String {
        let areasPermittedString = areasPermitted.map { $0.rawValue } // areasPermitted.joined(separator: " ")
        let rideAccessString = rideAccess.map { $0.rawValue } // rideAccess.joined(separator: " ")
       
        return "************************************************************\nPass holder: \(passHolder.entrantType.rawValue)\nAreas permitted: \(areasPermittedString)\nRide access: \(rideAccessString)\nDiscount: \(discount.description)\n************************************************************"
    }
}
