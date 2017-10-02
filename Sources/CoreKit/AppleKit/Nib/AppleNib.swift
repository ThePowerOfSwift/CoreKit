//
//  AppleNib.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


#if os(iOS) || os(tvOS)
    
    import UIKit.UINib
    
    public typealias AppleNib = UINib
    
#endif
#if os(macOS)
    
    import AppKit.NSNib
    
    public typealias AppleNib = NSNib
    
    public extension AppleNib {

        convenience init?(nibName: String, bundle: AppleBundle?) {
            var bundleVar = Bundle.main
            if let bundle = bundle {
                bundleVar = bundle
            }
            if bundleVar.path(forResource: nibName, ofType: "nib") == nil {
                return nil
            }
            
            self.init(nibNamed: NSNib.Name(rawValue: nibName), bundle: bundle)
        }
    }

#endif

#if os(iOS) || os(tvOS) || os(macOS)
    
public protocol Nib {
    
    static var nib: AppleNib? { get }
}

extension Nib where Self: UniqueIdentifier {
    
    public static var nib: AppleNib? { return AppleNib(nibName: self.uniqueIdentifier, bundle: .main) }
}


extension NSObject: Nib {}

#endif

