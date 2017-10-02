//
//  AppleFont+Size.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


#if os(iOS) || os(tvOS)

    import CoreGraphics
    import Foundation.NSAttributedString

    public extension AppleFont {

        public func size(ofString string: String, constrainedToWidth width: Double) -> CGSize {
            let attr: [NSAttributedStringKey:AnyObject] = [NSAttributedStringKey.font: self]
            let size = CGSize(width: width, height: Double.greatestFiniteMagnitude)

            return string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attr, context: nil).size
        }
        
    }
    
#endif
