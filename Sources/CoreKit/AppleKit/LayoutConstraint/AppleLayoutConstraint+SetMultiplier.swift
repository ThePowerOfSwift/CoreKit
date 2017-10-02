//
//  AppleLayoutConstraint+SetMultiplier.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)
    import CoreGraphics
    
    public extension AppleLayoutConstraint {
        
        func setMultiplier(multiplier: CGFloat) {
            let newConstraint = AppleLayoutConstraint(
                item: self.firstItem as Any,
                attribute: self.firstAttribute,
                relatedBy: self.relation,
                toItem: self.secondItem,
                attribute: self.secondAttribute,
                multiplier: multiplier,
                constant: self.constant
            )
            
            newConstraint.priority         = priority
            newConstraint.shouldBeArchived = self.shouldBeArchived
            newConstraint.identifier       = self.identifier
            newConstraint.isActive         = self.isActive
            
            AppleLayoutConstraint.deactivate([self])
            AppleLayoutConstraint.activate([newConstraint])
        }
    }
#endif

