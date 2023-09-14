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
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


#if canImport(UIKit)
public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
