//
//  AppleColor+Init.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics


public extension AppleColor {

    public convenience init(red255: CGFloat, green255: CGFloat, blue255: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: red255 / 255.0, green: green255 / 255.0, blue: blue255 / 255.0, alpha: alpha)
    }
    
    public convenience init(cyan c: CGFloat, magenta m: CGFloat, yellow y : CGFloat, black k: CGFloat, alpha a: CGFloat) {
        let r = (1.0-k)-(1.0-k)*c
        let g = (1.0-k)-(1.0-k)*m
        let b = (1.0-k)-(1.0-k)*y
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    public convenience init(red: CGFloat, yellow: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r = red
        var y = yellow
        var b = blue
        
        let whiteness = min(r, min(y, b))
        r -= whiteness
        y -= whiteness
        b -= whiteness
        
        let my = max(r, max(y, b))
        var g = min(y, b)
        y -= g
        b -= g
        
        if b > 0 && g > 0 {
            b *= 2.0
            g *= 2.0
        }
        
        r += y
        g += y
        
        let mg = max(r, max(g, b))
        if mg > 0 {
            let n = my / mg
            r *= n
            g *= n
            b *= n
        }
        r += whiteness
        g += whiteness
        b += whiteness
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

