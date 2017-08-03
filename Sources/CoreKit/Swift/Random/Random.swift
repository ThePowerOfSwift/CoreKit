//
//  Random.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 06/09/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//


//public protocol RandomValue {
//
//    /**
//     Generates a random value from the given type
//
//     - returns: A random value
//     */
//    static var random: Self { get }
//}
//
//
//public protocol RandomRange: Comparable {
//
//    /**
//     Generates a random boolean value
//
//     - parameter range: A range to limit random value generation
//
//     - returns: A random value from the given range
//     */
//    static func random(_ range: ClosedRange<Self>) -> Self
//}
//
//
//public protocol Randomizable {
//
//    /**
//     Randomize a given type (mutating)
//     */
//    mutating func randomize()
//
//    /**
//     Randomize a given type (non-mutating)
//
//     - returns: A random bool value
//     */
//    func randomized() -> Self
//}
//
//public protocol RandomFloatingPoint: FloatingPoint, RandomValue, RandomRange {}
//
//
//public extension RandomFloatingPoint {
//
//    /**
//     Randomize a floating point number
//
//     - returns: A random value between 0 and 1
//     */
//    public static var random: Self {
//        return self.init(arc4random()) / 0xFFFFFFFF
//    }
//
//    /**
//     Generates a random floating point value
//
//     - parameter range: A range to limit random value generation
//
//     - returns: A random value from the given range
//     */
//    public static func random(_ range: ClosedRange<Self>) -> Self {
//        return self.random * (range.upperBound - range.lowerBound) + range.upperBound
//    }
//}
//
//////////////////////////////////////////////////////////////////////////////////////////////////////
////  RandomFloatingPoint conformance (Float, Double)
//////////////////////////////////////////////////////////////////////////////////////////////////////
//
//extension Float: RandomFloatingPoint { }
//extension Double: RandomFloatingPoint { }
//
//
//////////////////////////////////////////////////////////////////////////////////////////////////////
////  Boolean
//////////////////////////////////////////////////////////////////////////////////////////////////////
//
//extension Bool: RandomValue {
//
//    /**
//     Generates a random boolean value
//
//     - returns: A random bool value
//     */
//    public static var random: Bool {
//        return arc4random_uniform(2) == 1
//    }
//}
//
//////////////////////////////////////////////////////////////////////////////////////////////////////
////  internal integer architecture extension
//////////////////////////////////////////////////////////////////////////////////////////////////////
//
//enum CPUArch: UInt8 {
//
//    case Arch32 = 32
//    case Arch64 = 64
//}
//
//extension Integer {
//
//    static var architecture: CPUArch {
//        return MemoryLayout<Int>.size == MemoryLayout<Int64>.size ? .Arch64 : .Arch32
//    }
//}
//
//private func arc4random<T: ExpressibleByIntegerLiteral> (_ type: T.Type) -> T {
//    var r: T = 0
//    arc4random_buf(&r, MemoryLayout<T>.size)
//    return r
//}
//
//
//
//extension Int: RandomRange {
//
//    public static func random(_ range: ClosedRange<Int>) -> Int {
//        if Int.architecture == .Arch64 {
//            return Int(Int64.random(Int64(range.lowerBound)...Int64(range.upperBound)))
//        }
//        return Int(Int32.random(Int32(range.lowerBound)...Int32(range.upperBound)))
//    }
//}
//
//extension Int: RandomValue {
//
//    public static var random: Int {
//        return self.random(Int.min...Int.max)
//    }
//}
//
//
//extension Int64: RandomRange {
//
//    public static func random(_ range: ClosedRange<Int64>) -> Int64 {
//        let (s, overflow) = Int64.subtractWithOverflow(range.upperBound, range.lowerBound)
//        let u = overflow ? UInt64.max - UInt64(~s) : UInt64(s)
//
//        let r = UInt64.random(UInt64.min...u)
//
//        if r > UInt64(Int64.max) {
//            return Int64(r - (UInt64(~range.lowerBound) + 1))
//        }
//        return Int64(r) + range.lowerBound
//    }
//}
//
//extension Int32: RandomRange {
//
//    public static func random(_ range: ClosedRange<Int32>) -> Int32 {
//        let r = arc4random_uniform(UInt32(Int64(range.upperBound) - Int64(range.lowerBound)))
//        return Int32(Int64(r) + Int64(range.lowerBound))
//    }
//}
//
//
//extension UInt: RandomRange {
//
//    public static func random(_ range: ClosedRange<UInt>) -> UInt {
//        if Int.architecture == .Arch64 {
//            return UInt(UInt64.random(UInt64(range.lowerBound)...UInt64(range.upperBound)))
//        }
//        return UInt(UInt32.random(UInt32(range.lowerBound)...UInt32(range.upperBound)))
//    }
//}
//
//
//extension UInt64: RandomRange {
//
//    public static func random(_ range: ClosedRange<UInt64>) -> UInt64 {
//        var m: UInt64
//        let u = range.upperBound - range.lowerBound
//        var r = arc4random(UInt64.self)
//
//        if u > UInt64(Int64.max) {
//            m = 1 + ~u
//        }
//        else {
//            m = ((max - (u * 2)) + 1) % u
//        }
//
//        while r < m {
//            r = arc4random(UInt64.self)
//        }
//
//        return (r % u) + range.lowerBound
//    }
//}
//
//extension UInt32: RandomRange {
//
//    public static func random(_ range: ClosedRange<UInt32>) -> UInt32 {
//        return arc4random_uniform(range.upperBound - range.lowerBound) + range.lowerBound
//    }
//}
//
//
//// extension Range where Bound : Comparable {
////     var randomValue: Bound {
////         return self.upperBound
////     }
//// }
