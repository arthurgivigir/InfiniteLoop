//
//  View+Modifiers.swift
//  
//
//  Created by Arthur Givigir on 15/04/23.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func appPadding(_ edges: Edge.Set = .all, _ length: Sizes? = nil) -> some View {
        padding(edges, CGFloat(length?.rawValue ?? .zero))
    }
}


#if canImport(UIKit)
public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
