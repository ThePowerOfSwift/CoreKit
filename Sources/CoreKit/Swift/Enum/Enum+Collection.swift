//
//  Enum+Collection.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

/**
 EnumCollection protocol
 
 This protocol allows enumerations to get all the enum values
 */
public protocol EnumCollection: Hashable {
    
    /**
     Returns a sequence from the enumerations
     */
    static func cases() -> AnySequence<Self>
    
    /**
     Returns all the values of the enum
     */
    static var allValues: [Self] { get }
}

/**
 EnumCollection protocol default implementation
 */
public extension EnumCollection {
    
    /**
     Returns a sequence from the enumerations
     */
    public static func cases() -> AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
    }
    
    /**
     Returns all the values of the enum
     */
    public static var allValues: [Self] {
        return Array(Self.cases())
    }
    
}
