//
//  SwipeControl.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 23/03/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation

struct SwipeController {
    static func hasEntrantSwipedDouble(entrant: Entrant) -> Bool {
        let currentSwipeTime = Date()
        
        if let lastSwipe = entrant.accessPass?.lastSwipe {
            // Entrant has swiped the pass before
            let timeIntervalSinceLastSwipe = Int(currentSwipeTime.timeIntervalSince(lastSwipe))
            
            if timeIntervalSinceLastSwipe > 5 {
                return false
            } else {
                return true
            }
            
        } else {
            // Entrant has never swiped before
            entrant.accessPass?.lastSwipe = currentSwipeTime
            return false
        }
    }
}



