//
//  AppleView+AnimateBackgroundColor.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
    public extension AppleView {
        
        public func animateBackgroundColor(color: AppleColor, duration: Double = 0.5) {
            let originalColor = self.backgroundColor?.copy() as? AppleColor ?? AppleColor.clear
            
            AppleView.animate(withDuration: duration, animations: {
                self.backgroundColor = color
                AppleView.animate(withDuration: duration, animations: {
                    self.backgroundColor = originalColor
                })
            })
        }
        
    }

#endif
