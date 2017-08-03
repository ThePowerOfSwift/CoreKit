//
//  Manipulation-Color.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2016. 10. 05..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//
#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
import Foundation
import CoreGraphics

public extension AppleColor
{
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: helpers
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    public func brightness(percent: CGFloat, lighter: Bool) -> AppleColor {
        let v = self.hsba
        var newBrightness = max(v.b * percent, 0.0)
        if lighter {
            newBrightness = min(v.b * percent, 1.0)
        }
        return AppleColor(hue: v.h, saturation: v.s, brightness: newBrightness, alpha: v.a)
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: light & dark & black & white api
    ///////////////////////////////////////////////////////////////////////////////////////////////////


    public func lighterColor(percent: CGFloat = 1.25) -> AppleColor {
        return brightness(percent: percent, lighter: true)
    }

    public func darkerColor(percent: CGFloat = 0.75) -> AppleColor {
        return brightness(percent: percent, lighter: false)
    }

    public var isDarkColor : Bool {
        return self.lumens < 0.5
    }

    public var isBlackOrWhite : Bool {
        let v = self.rgba

        if v.r > 0.91 && v.g > 0.91 && v.b > 0.91 {
            return true //white
        }
        if v.r < 0.09 && v.g < 0.09 && v.b < 0.09 {
            return true //black
        }

        return false
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: hsla api
    ///////////////////////////////////////////////////////////////////////////////////////////////////


    public func set(alpha: CGFloat) -> AppleColor {
        return self.withAlphaComponent(alpha)
    }

    public func set(hue: CGFloat) -> AppleColor {
        let v = self.hsba

        return AppleColor(hue: hue, saturation: v.s, brightness: v.b, alpha: v.a)
    }

    public func set(saturation: CGFloat) -> AppleColor {
        let v = self.hsba

        return AppleColor(hue: v.h, saturation: saturation, brightness: v.b, alpha: v.a)
    }

    public func set(brightness: CGFloat) -> AppleColor {
        let v = self.hsba
        return AppleColor(hue: v.h, saturation: v.s, brightness: brightness, alpha: v.a)
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: style api
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    public func isDistinct(color: AppleColor, threshold : CGFloat = 0.25) -> Bool {
        let rgba1 = self.rgba
        let rgba2 = color.rgba

        if  fabs(rgba1.r - rgba2.r) > threshold ||
            fabs(rgba1.g - rgba2.g) > threshold ||
            fabs(rgba1.b - rgba2.b) > threshold ||
            fabs(rgba1.a - rgba2.a) > threshold
        {
            // check for grays, prevent multiple gray colors
            if  fabs(rgba1.r - rgba1.g) < 0.03 &&
                fabs(rgba1.r - rgba1.b) < 0.03 &&
                fabs(rgba2.r - rgba2.g) < 0.03 &&
                fabs(rgba2.r - rgba2.b) < 0.03
            {
                return false
            }
            return true
        }
        return false
    }

    public func isContrasting(color: AppleColor) -> Bool {
        let bLum = self.lumens
        let fLum = color.lumens

        var contrast : CGFloat = 0.0;

        if bLum > fLum {
            contrast = (bLum + 0.05) / (fLum + 0.05);
        }
        else {
            contrast = (fLum + 0.05) / (bLum + 0.05);
        }
        //return contrast > 3.0; //3-4.5 W3C recommends 3:1 ratio, but that filters too many colors
        return contrast > 1.6;
    }

}

#endif