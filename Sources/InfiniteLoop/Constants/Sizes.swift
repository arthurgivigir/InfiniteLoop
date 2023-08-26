//
//  Spaces.swift
//  
//
//  Created by Arthur Givigir on 02/04/23.
//

import Foundation

public enum Sizes: Float {
    /// Size 0.0
    case size00 = 0.0
    
    /// Size 2.0
    case size02 = 2.0
    
    /// Size 4.0
    case size04 = 4.0
    
    /// Size 6.0
    case size06 = 6.0
    
    /// Size 8.0
    case size08 = 8.0
    
    /// Size 10.0
    case size10 = 10.0
    
    /// Size 12.0
    case size12 = 12.0
    
    /// Size 14.0
    case size14 = 14.0
    
    /// Size 16.0
    case size16 = 16.0
    
    /// Size 18.0
    case size18 = 18.0
    
    /// Size 20.0
    case size20 = 20.0
    
    // Return a CGFloat
    public var cgFloat: CGFloat {
        CGFloat(self.rawValue)
    }
    
}
