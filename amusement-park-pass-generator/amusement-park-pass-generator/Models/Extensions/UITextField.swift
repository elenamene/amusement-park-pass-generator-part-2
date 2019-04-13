//
//  TextField.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 07/04/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

// Styling the disabled textfields
extension UITextField {
    override open var isEnabled: Bool {
        didSet {
             alpha = isEnabled ? 1.0 : 0.2
        }
    }
}
