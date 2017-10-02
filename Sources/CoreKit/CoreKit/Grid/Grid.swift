//
//  Grid.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)
    
    import CoreGraphics
    
#if os(iOS) || os(tvOS)
    import UIKit.UITraitCollection
#endif
    
    open class Grid {

        private weak var view: AppleView!
        
        open var screenSize: CGSize = AppleScreen.default.bounds.size
        
        open var size: CGSize { return self.view.bounds.size }
        
        open var columns: CGFloat = 1
        open var margin: CGFloat  = 0
        open var padding: CGFloat = 0
        
        open var insets: AppleEdgeInsets?
        open var lineSpacing: CGFloat?
        open var itemSpacing: CGFloat?
        
        public init(view: AppleView) {
            self.view = view
        }
        
        #if os(iOS) || os(tvOS)
        open weak var traitCollection: UITraitCollection!
        
        public init(view: AppleView, traitCollection: UITraitCollection? = nil) {
            self.view = view
            self.traitCollection = traitCollection ?? view.traitCollection
        }
        
        open var isSmallPortraitScreen: Bool {
            return self.traitCollection.horizontalSizeClass == .compact &&
                self.traitCollection.verticalSizeClass == .regular
        }
        #endif
        
        open func size(ratio: CGFloat,
                       numberOfItems: CGFloat = 1,
                       padding: CGFloat = 0,
                       columns: CGFloat? = nil,
                       leftInset: Bool = true,
                       rightInset: Bool = true) -> CGSize
        {
            let size = self.width(numberOfItems, padding: padding, columns: columns)
            return CGSize(width: size, height: size * ratio)
        }
        
        open func size(height: CGFloat,
                       numberOfItems: CGFloat = 1,
                       padding: CGFloat = 0,
                       columns: CGFloat? = nil,
                       leftInset: Bool = true,
                       rightInset: Bool = true) -> CGSize {
            let size = self.width(numberOfItems, padding: padding, columns: columns)
            return CGSize(width: size, height: height)
        }
        
        open func width(_ size: CGFloat = 1,
                        padding: CGFloat = 0,
                        columns: CGFloat? = nil,
                        leftInset: Bool = true,
                        rightInset: Bool = true) -> CGFloat {
            var cols = self.columns
            if let c = columns {
                cols = c
            }
            var leftMargin  = (self.insets?.left ?? self.margin)
            if !leftInset {
                leftMargin = 0
            }
            var rightMargin = (self.insets?.right ?? self.margin)
            if !rightInset {
                rightMargin = 0
            }
            let itemSpacing = (self.itemSpacing ?? self.padding)
            
            let width = self.view.bounds.size.width - leftMargin - rightMargin - padding * itemSpacing
            
            return width / cols * size
        }
        
    }
    
#endif

