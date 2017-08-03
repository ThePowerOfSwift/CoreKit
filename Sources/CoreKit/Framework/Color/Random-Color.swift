//
//  Random-Color.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2016. 10. 05..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//
#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
import Foundation
import CoreGraphics


fileprivate extension CGFloat {

    static var random: CGFloat {
        return CGFloat(arc4random())
    }

}


public extension AppleColor
{
    /**
     Generates a random color using arc4random with hsl generation

     - returns: The random color object
     */
    public static var randomColor: AppleColor {

        let hue        = fmod(CGFloat.random, 256) / 256
        let saturation = fmod(CGFloat.random, 128) / 256 + 0.5
        let brightness = fmod(CGFloat.random, 128) / 256 + 0.5

        return AppleColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }

    /**
     Generates a random color using drand48 with rgb generation

     - returns: The random color object
     */
    public static var randomRGBColor: AppleColor {
        let red   = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue  = CGFloat(drand48())

        return AppleColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
#endif