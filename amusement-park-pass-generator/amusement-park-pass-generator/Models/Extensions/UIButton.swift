//
//  UIButton.swift
//  amusement-park-pass-generator
//
//  Created by Elena Meneghini on 01/04/2019.
//  Copyright © 2019 Elena Meneghini. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(type: ButtonType = .custom, title: String) {
        self.init(type: type)
        
        titleLabel?.font = .systemFont(ofSize: 16)
        setTitle(title, for: .normal)
        setTitleColor(.myLightPurple, for: .normal)
        setTitleColor(.white, for: .selected)
    }
    
    override open var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.2
        }
    }
}
