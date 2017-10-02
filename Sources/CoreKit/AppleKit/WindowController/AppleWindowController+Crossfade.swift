//
//  AppleWindowController+Crossfade.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(macOS)
    
import AppKit

public extension AppleWindowController {
    
    public func crossfade(view: AppleView, duration: TimeInterval = 0.5) {
        guard let window = self.window, let contentView = window.contentView, contentView != view else {
            return
        }

        let oldAnimation: [NSViewAnimation.Key:Any] = [
            NSViewAnimation.Key.effect : NSViewAnimation.EffectName.fadeOut,
            NSViewAnimation.Key.target : contentView
        ]

        let newAnimation: [NSViewAnimation.Key:Any] = [
            NSViewAnimation.Key.effect : NSViewAnimation.EffectName.fadeIn,
            NSViewAnimation.Key.target : view
        ]
        
        self.window?.contentView        = view
        
        let animation                   = NSViewAnimation(viewAnimations: [oldAnimation, newAnimation])
        animation.animationBlockingMode = .blocking
        animation.duration              = duration
        animation.start()
    }
    
}

#endif
