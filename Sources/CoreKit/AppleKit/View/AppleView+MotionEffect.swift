//
//  AppleView+MotionEffect.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS)

    import CoreGraphics
    import UIKit.UIMotionEffect

    
    public extension AppleView {
    
        /**
         Creates an x and y motion for the view
         
         - parameter amplitude: The amplitude of the motion
         */

        func addMotionEffect(amplitude: CGFloat = 20) {
            let min = -amplitude
            let max = +amplitude
            let xAxis = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
            xAxis.minimumRelativeValue = min
            xAxis.maximumRelativeValue = max

            let yAxis = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
            yAxis.minimumRelativeValue = min
            yAxis.maximumRelativeValue = max
            
            let group = UIMotionEffectGroup()
            group.motionEffects = [xAxis, yAxis]
            
            self.addMotionEffect(group)
        }
    }


#endif
