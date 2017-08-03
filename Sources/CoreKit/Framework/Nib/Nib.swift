//
//  Nib.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 04/09/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import Foundation

public protocol Nib {

    static var nib: AppleNib? { get }
}

extension Nib where Self: Unique {

    public static var nib: AppleNib? { return AppleNib(nibName: self.uniqueIdentifier, bundle: .main) }
}

extension NSObject: Nib {}

#endif
