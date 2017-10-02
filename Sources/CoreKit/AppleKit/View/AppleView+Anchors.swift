//
//  AppleView+Anchors.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

    import CoreGraphics
    
    
    public extension AppleView {
        
        public func leadingAnchorEqual(toView: AppleView, constant: CGFloat = 0) {
            self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: constant).isActive = true
        }
        
        public func topAnchorEqual(toView: AppleView, constant: CGFloat = 0) {
            self.topAnchor.constraint(equalTo: toView.topAnchor, constant: constant).isActive = true
        }
        
        public func bottomAnchorEqual(toView: AppleView, constant: CGFloat = 0) {
            self.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -constant).isActive = true
        }
        
        public func trailingAnchorEqual(toView: AppleView, constant: CGFloat = 0) {
            self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -constant).isActive = true
        }

        public func verticalAnchors(toView: AppleView, constant: CGFloat = 0) {
            self.topAnchorEqual(toView: toView, constant: constant)
            self.bottomAnchorEqual(toView: toView, constant: constant)
        }
        
        public func horizontalAnchors(toView: AppleView, constant: CGFloat = 0) {
            self.leadingAnchorEqual(toView: toView, constant: constant)
            self.trailingAnchorEqual(toView: toView, constant: constant)
        }

        public func fillAnchors(toView: AppleView, constant: CGFloat = 0) {
            self.leadingAnchorEqual(toView: toView, constant: constant)
            self.trailingAnchorEqual(toView: toView, constant: constant)
            self.topAnchorEqual(toView: toView, constant: constant)
            self.bottomAnchorEqual(toView: toView, constant: constant)
        }
        
        public func widthAnchorEqual(constant: CGFloat) {
            self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        }
        
        public func heightAnchorEqual(constant: CGFloat) {
            self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        }
        
        public func widthAnchorEqual(toView: AppleView, constant: CGFloat = 0) {
            self.widthAnchor.constraint(equalTo: toView.widthAnchor, constant: constant).isActive = true
        }
        
        public func heightAnchorEqual(toView: AppleView, constant: CGFloat = 0) {
            self.heightAnchor.constraint(equalTo: toView.heightAnchor, constant: constant).isActive = true
        }
        
        public func widthAnchorScaled(toView: AppleView, multiplier: CGFloat = 1.0) {
            self.widthAnchor.constraint(equalTo: toView.widthAnchor, multiplier: multiplier).isActive = true
        }
        
        public func heightAnchorScaled(toView: AppleView, multiplier: CGFloat = 1.0) {
            self.heightAnchor.constraint(equalTo: toView.heightAnchor, multiplier: multiplier).isActive = true
        }
        
        public func aspectAnchorEqual(toView: AppleView, multiplier: CGFloat = 1.0) {
            self.widthAnchor.constraint(equalTo: toView.heightAnchor, multiplier: multiplier).isActive = true
        }
        
        public func aspectAnchorEqual(multiplier: CGFloat = 1.0) {
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
        }
        
        public func centerXAnchorEqual(toView: AppleView, constant: CGFloat = 0) {
            self.centerXAnchor.constraint(equalTo: toView.centerXAnchor, constant: constant).isActive = true
        }
        
        public func centerYAnchorEqual(toView: AppleView, constant: CGFloat = 0) {
            self.centerYAnchor.constraint(equalTo: toView.centerYAnchor, constant: constant).isActive = true
        }
        
        public func centerAnchors(toView: AppleView, constant: CGFloat = 0) {
            self.centerXAnchorEqual(toView: toView, constant: constant)
            self.centerYAnchorEqual(toView: toView, constant: constant)
        }
        
        public func topBottomAnchorEqual(toView: AppleView, constant: CGFloat = 0) {
            self.topAnchor.constraint(equalTo: toView.bottomAnchor, constant: constant).isActive = true
        }

        public func leadingTrailingAnchorEqual(toView: AppleView, constant: CGFloat = 0) {
            self.leadingAnchor.constraint(equalTo: toView.trailingAnchor, constant: constant).isActive = true
        }
        
        public func bottomTopAnchorEqual(toView: AppleView, constant: CGFloat = 0) {
            self.bottomAnchor.constraint(equalTo: toView.topAnchor, constant: -constant).isActive = true
        }
        
        public func trailingLeadingAnchorEqual(toView: AppleView, constant: CGFloat = 0) {
            self.trailingAnchor.constraint(equalTo: toView.leadingAnchor, constant: -constant).isActive = true
        }
    }
    
#endif
