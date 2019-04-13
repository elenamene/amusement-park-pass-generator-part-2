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
