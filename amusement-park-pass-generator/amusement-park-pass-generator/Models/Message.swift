//
//  Message.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 24/03/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

// MARK: - Message

enum Message {
    case happyBirthday(Ageable)
    case doubleSwiping(Entrant)
    
    var text: String {
        switch self {
        case .happyBirthday(let entrant) where entrant is Employee: return employeeBirthdayMessage(entrant: entrant as! Employee)
        case .happyBirthday(let entrant) where entrant is Guest: return guestBirthdayMessage()
        case .happyBirthday(_): return "Happy birthday!!!"
        case .doubleSwiping(let entrant): return doubleSwipingMessage(entrant: entrant)
        }
    }
}

// MARK: - Helper methods

extension Message {
    func employeeBirthdayMessage(entrant: Employee) -> String {
        let name = entrant.firstName
        
        return """
        Happy birthday \(name)!
        From all of us wishing you nothing but fulfilment and happiness on this special day!
        Enjoy your free afternoon.
        All the best.
        """
    }
    
    func guestBirthdayMessage() -> String {
        return """
        Happy birthday!
        We want to wish you a very special day here with a lot of fun.
        Enjoy a free ride!
        """
    }
    
    func doubleSwipingMessage(entrant: Entrant) -> String {
        if let pass = entrant.accessPass, let lastSwipeTime = pass.lastSwipe {
            return """
            We have recorded a swipe at \(lastSwipeTime).
            Double swiping is not permitted. Please contact an assitant.
            """
        } else {
            return """
            Double swiping is not permitted. Please contact an assitant.
            """
        }
    }
}

