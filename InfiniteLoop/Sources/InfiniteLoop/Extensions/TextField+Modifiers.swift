//
//  TextField+Modifiers.swift
//  
//
//  Created by Arthur Givigir on 15/04/23.
//

import SwiftUI

public extension Binding where Value == String {
    func maxlenght(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
