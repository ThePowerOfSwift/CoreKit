//
//  Unique.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 04/09/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//

import Foundation


public protocol Unique: class {

    static var uniqueIdentifier: String { get }
}

extension Unique {

    public static var uniqueIdentifier: String { return String(describing: self) }
}

extension NSObject: Unique {}
