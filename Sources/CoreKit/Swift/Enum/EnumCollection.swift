//
//  EnumCollection.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 01. 04..
//  Copyright © 2017. Tibor Bodecs. All rights reserved.
//



public protocol EnumCollection: Hashable {
    static func cases() -> AnySequence<Self>
    static var allValues: [Self] { get }
}

extension EnumCollection {

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

    public static var allValues: [Self] {
        return Array(Self.cases())
    }
    
}
