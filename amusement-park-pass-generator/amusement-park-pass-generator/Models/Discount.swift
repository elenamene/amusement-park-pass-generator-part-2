//
//  Discount.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Elena Meneghini on 19/03/2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

struct Discount {
    typealias Percentage = Int
    
    var food: Percentage
    var merchandise: Percentage

    init(onFood foodDiscount: Percentage, onMerchandise merchandiseDiscount: Percentage) {
        self.food = foodDiscount
        self.merchandise = merchandiseDiscount
    }
}

extension Discount: CustomStringConvertible {
    var description: String {
        if food == 0 && merchandise == 0 {
            return "No Discunt Available"
        } else {
            return "\(food)% on food, \(merchandise)% on merchandise"
        }
    }
}

extension Discount: Equatable {
    static func == (lhs: Discount, rhs: Discount) -> Bool {
        return
            lhs.food == rhs.food &&
            lhs.merchandise == rhs.merchandise
    }
}


