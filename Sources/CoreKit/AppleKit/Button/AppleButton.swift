//
//  AppleButton.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) 
    
    import UIKit.UIButton
    
    public typealias AppleButton = UIButton
    
#endif
#if os(macOS)
    
    import AppKit.NSButton
    
    public typealias AppleButton = NSButton
    
    public extension AppleButton {

        public func setTextColor(color: AppleColor) {
            let attributedString = self.attributedTitle.mutableCopy() as! NSMutableAttributedString
            let range = NSMakeRange(0, attributedString.length)
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
            self.attributedTitle = attributedString
        }
    }

#endif

#if os(iOS) || os(tvOS) || os(macOS)

public typealias AppleButtonBlock = (AppleButton) -> Void

#endif


