//
//  AppleColor+Blend.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics


public extension AppleColor {
    
    public func blendRGB(color: AppleColor) -> AppleColor {
        let colors = [self, color]
        
        var maxRed: CGFloat   = 0.0
        var maxGreen: CGFloat = 0.0
        var maxBlue: CGFloat  = 0.0
        
        for color in colors {
            let components  = color.rgba    
            maxRed         += components.r
            maxGreen       += components.g
            maxBlue        += components.b
        }
        //use count-1 for truer light mix (more whites)
        let div = CGFloat(sqrt(sqrt(Double(colors.count))))
        
        let r = maxRed/div
        let g = maxGreen/div
        let b = maxBlue/div
        
        return AppleColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    public func blendRGB(color: AppleColor, blendValue unsafeAlpha: CGFloat) -> AppleColor {
        let alpha      = min(1.0, max(0.0, unsafeAlpha))
        let beta       = 1.0 - alpha
        let alphaColor = self.rgba
        let betaColor  = color.rgba
        
        let r = alphaColor.r * beta + betaColor.r * alpha
        let g = alphaColor.g * beta + betaColor.g * alpha
        let b = alphaColor.b * beta + betaColor.b * alpha
        
        return AppleColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    public func blendRGBBetween(color: AppleColor, steps: Int) -> [AppleColor] {
        if steps == 0 {
            return []
        }
        if steps == 1 {
            return [self]
        }
        if steps == 2 {
            return [self, color]
        }
        
        let stepSize : CGFloat = 1.0 / CGFloat(steps - 1)
        
        var colors : [AppleColor] = []
        
        
        let elements = stride(from: 2, to: steps-1, by: 1)
            .map { self.blendRGB(color: color, blendValue: (stepSize * CGFloat($0))) }
        
        colors.append(self)
        colors.append(contentsOf: elements)
        colors.append(color)
        
        return colors
    }
    
    public func blendRGBMax(color: AppleColor) -> AppleColor {
        let alphaColor = self.rgba
        let betaColor  = color.rgba
        
        let r = max(alphaColor.r, betaColor.r)
        let g = max(alphaColor.g, betaColor.g)
        let b = max(alphaColor.b, betaColor.b)
        let a = max(alphaColor.a, betaColor.a)
        
        return AppleColor(red: r, green: g, blue: b, alpha: a)
    }
    
    public func blendRYB(color: AppleColor, blendValue unsafeAlpha: CGFloat) -> AppleColor {
        let alpha      = min(1.0, max(0.0, unsafeAlpha))
        let beta       = 1.0 - alpha
        let alphaColor = self.ryba
        let betaColor  = color.ryba
        
        let r = alphaColor.r * beta + betaColor.r * alpha
        let g = alphaColor.y * beta + betaColor.y * alpha
        let b = alphaColor.b * beta + betaColor.b * alpha
        
        return AppleColor(red: r, yellow: g, blue: b, alpha: 1.0)
    }
    
    public func blendRYB(color: AppleColor) -> AppleColor {
        let colors = [self, color]
        
        var maxRed : CGFloat    = 0.0
        var maxYellow : CGFloat = 0.0
        var maxBlue : CGFloat   = 0.0
        
        for color in colors {
            let components  = color.ryba
            maxRed         += components.r
            maxYellow      += components.y
            maxBlue        += components.b
        }
        
        let count = CGFloat(colors.count)
        let div   = sqrt((sqrt(count-maxRed/count)))
        let r     = maxRed/div
        let y     = maxYellow/div
        let b     = maxBlue/div
        
        return AppleColor(red: r, yellow: y, blue: b, alpha: 1.0)
    }
    
    public func blendCMYK(color: AppleColor) -> AppleColor {
        let colors = [self, color]
        var maxCyan : CGFloat    = 0.0
        var maxMagenta : CGFloat = 0.0
        var maxYellow : CGFloat  = 0.0
        var maxBlack : CGFloat   = 0.0
        
        for color in colors {
            let components = color.cmyka
            maxCyan        += components.c
            maxMagenta     += components.m
            maxYellow      += components.y
            maxBlack       += components.k
        }
        
        let div = sqrt(CGFloat(colors.count + 1))
        
        let c = maxCyan/div
        let m = maxMagenta/div
        let y = maxYellow/div
        let k = maxBlack/sqrt(sqrt(CGFloat(colors.count)))
        
        return AppleColor(cyan: c, magenta: m, yellow: y, black: k, alpha: 1.0)
    }
}

