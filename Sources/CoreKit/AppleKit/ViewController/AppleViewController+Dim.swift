//
//  AppleViewController+Dim.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
    import CoreGraphics
    
    public extension AppleViewController {
        
        private static var DimTag: Int = 6580589 //dim string in decimal
        
        public func dim(enabled: Bool, color: AppleColor = AppleColor.black, alpha: CGFloat = 0.25, speed: Double = 0.25) {
            if enabled {
                guard let view = self.view.subviews.last, view.tag != AppleViewController.DimTag else {
                    return
                }
                let dimView             = AppleView.create()
                dimView.tag             = AppleViewController.DimTag
                dimView.backgroundColor = color
                dimView.alpha           = 0.0
                self.view.addSubview(dimView)
                dimView.fillAnchors(toView: self.view)
                
                AppleView.animate(withDuration: speed) {
                    dimView.alpha = alpha
                }
            }
            else {
                guard let view = self.view.subviews.last, view.tag == AppleViewController.DimTag else {
                    return
                }
                AppleView.animate(withDuration: speed, animations: {
                    view.alpha = alpha
                }, completion: { complete in
                    view.removeFromSuperview()
                })
            }
        }
        
    }
    
#endif

