//
//  UniqueIdentifier.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


/**
 A unique identifier protocol for classes
 */
public protocol UniqueIdentifier: class {
    static var uniqueIdentifier: String { get }
    var uniqueIdentifier: String { get }
}

/**
 Default implementation for the UniqueIdentifier protocol
 */
public extension UniqueIdentifier {
    public static var uniqueIdentifier: String { return String(describing: self) }
    public var uniqueIdentifier: String { return type(of: self).uniqueIdentifier }
}
