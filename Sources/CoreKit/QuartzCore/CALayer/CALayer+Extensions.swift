//
//  CALayer+Extensions.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

    import QuartzCore.CALayer
    
    
    public extension CALayer {
        
        public func shadow(color: AppleColor = .black, opacity: Float = 1.0, radius: CGFloat = 1.0, offset: CGSize = .zero) {
            self.shadowColor   = color.cgColor
            self.shadowOpacity = opacity
            self.shadowRadius  = radius
            self.shadowOffset  = offset
        }
        
        public func roundedCorner(radius: CGFloat? = nil) {
            var cornerRadius = CGFloat(roundf(Float(self.frame.size.width / 2.0)))
            if let r = radius {
                cornerRadius = r
            }
            
            self.masksToBounds = true
            self.cornerRadius = cornerRadius
        }
        
        func border(color: AppleColor = .black, width: CGFloat = .scale) {
            self.borderColor = color.cgColor
            self.borderWidth = width
        }
        
        func rasterize() {
            self.shouldRasterize = true
            self.rasterizationScale = CGFloat.scale
        }
    }

#endif
