//
//  String.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 30/03/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

extension String {
    var getDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter.date(from: self)
    }
}

// Validation

extension String {
    func isLengthEqualOrGreaterThan(_ minLength: Int) -> Bool {
        return self.count >= minLength
    }
    
    func isValidFormat(regex: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self.lowercased())
    }
    
}


