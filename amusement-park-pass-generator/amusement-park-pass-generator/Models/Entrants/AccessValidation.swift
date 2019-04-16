//
//  AccessValidation.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 16/04/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation
import UIKit

enum AccessValidation: String {
    case pass = "Access Permitted"
    case fail = "Access Denied"
    
    func color() -> UIColor {
        switch self {
        case .pass: return UIColor.myGreen
        case .fail: return UIColor.myRed
        }
    }
    
    func image() -> UIImage {
        switch self {
        case .pass: return #imageLiteral(resourceName: "accessGranted")
        case .fail: return #imageLiteral(resourceName: "accessDenied")
        }
    }
    
    func soundName() -> (String) {
        switch self {
        case .pass: return "AccessGranted"
        case .fail: return "AccessDenied"
        }
    }
}
