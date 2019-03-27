//
//  Guest.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 19/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

enum GuestType {
    case classic
    case vip
    case freeChild
    //        case seasonPass
    //        case senior
}

// MARK: - Protocol Guest

protocol Guest: Entrant {
    var type: GuestType { get }
}

extension Guest {
    var entrantType: EntrantType {
        switch self.type {
        case .classic: return .classicGuest
        case .vip: return .vipGuest
        case .freeChild: return .freeChildGuest
        }
    }
}

// MARK: - Structs Guest

class ClassicGuest: Guest {
    var type: GuestType = .classic
    var accessPass: Pass?
}

class VIPGuest: Guest {
    var type: GuestType = .vip
    var accessPass: Pass?
}

class FreeChildGuest: Guest, Ageable {
    var type: GuestType = .freeChild
    var dateOfBirth: Date?
    var accessPass: Pass?
    
    init(dateOfBirth: Date) {
        self.dateOfBirth = dateOfBirth
    }
}


