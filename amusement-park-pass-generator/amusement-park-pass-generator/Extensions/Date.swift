//
//  Date.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 21/03/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

extension Date {
    var age: Int? {
        let now = Date()
        return Calendar.current.dateComponents([.year], from: self, to: now).year
    }
    
    var month: Int? {
        return Calendar.current.dateComponents([.month], from: self).month
    }
    
    var day: Int? {
        return Calendar.current.dateComponents([.day], from: self).day
    }
    
    func isSameDayAndMonthOfToday() -> Bool {
        let today = Date()
        return self.day == today.day && self.month == today.month
    }
    
    var stringDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter.string(from: self)
    }
}

