//
//  UICollection.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 11/04/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import Foundation
import UIKit

extension Sequence where Element: UIControl {
    func disableAll() {
        self.forEach { $0.isEnabled = false }
    }
    
    func enableAll() {
        self.forEach { $0.isEnabled = true }
    }
    
    func deselectAll(apartFrom selectedItem: Element) {
        for item in self {
            if item != selectedItem {
                item.isSelected = false
            } else {
                item.isSelected = true
            }
        }
    }
}
