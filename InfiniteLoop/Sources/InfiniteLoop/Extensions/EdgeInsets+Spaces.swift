//
//  EdgeInsets+Spaces.swift
//  
//
//  Created by Arthur Givigir on 02/04/23.
//

import Foundation
import SwiftUI

public extension EdgeInsets {
    init(top: Sizes, bottom: Sizes, leading: Sizes, trailing: Sizes) {
        self.init(
            top: CGFloat(top.rawValue),
            leading: CGFloat(leading.rawValue),
            bottom: CGFloat(bottom.rawValue),
            trailing: CGFloat(trailing.rawValue)
        )
    }
}
