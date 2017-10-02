//
//  AppleEdgeInsets+Init.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics

public extension AppleEdgeInsets {
    
    public static func top(size: CGFloat) -> AppleEdgeInsets {
        return AppleEdgeInsets(top: size, left: 0, bottom: 0, right: 0)
    }
    
    public static func left(size: CGFloat) -> AppleEdgeInsets {
        return AppleEdgeInsets(top: 0, left: size, bottom: 0, right: 0)
    }
    
    public static func bottom(size: CGFloat) -> AppleEdgeInsets {
        return AppleEdgeInsets(top: 0, left: 0, bottom: size, right: 0)
    }
    
    public static func right(size: CGFloat) -> AppleEdgeInsets {
        return AppleEdgeInsets(top: 0, left: 0, bottom: 0, right: size)
    }
    
    public static func vertical(size: CGFloat) -> AppleEdgeInsets {
        return AppleEdgeInsets(top: size, left: 0, bottom: size, right: 0)
    }
    
    public static func horizontal(size: CGFloat) -> AppleEdgeInsets {
        return AppleEdgeInsets(top: 0, left: size, bottom: 0, right: size)
    }

    public static func all(size: CGFloat) -> AppleEdgeInsets {
        return AppleEdgeInsets(top: size, left: size, bottom: size, right: size)
    }
}
