//
//  String+Date.swift
//  
//
//  Created by Arthur Givigir on 02/04/23.
//

import Foundation

public extension String {
    var dateFormatter: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
}
