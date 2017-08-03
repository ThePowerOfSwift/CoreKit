//
//  Components-Color.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2016. 10. 05..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//
#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
import Foundation
import CoreGraphics


extension AppleColor
{

    private var rgbColorSpace : AppleColor {
        let c = self.cgColor.components
        let a = self.cgColor.alpha

        return AppleColor(red: c![0], green: c![1], blue: c![2], alpha: a)
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: rgba
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    public var rgba : (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let convertedColor = self.rgbColorSpace
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a : CGFloat = 0
        convertedColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r:r, g:g, b:b, a:a)
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: ryba
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    public var ryba : (r: CGFloat, y: CGFloat, b: CGFloat, a: CGFloat) {
        let components = self.rgba
        var r = components.r
        var g = components.g
        var b = components.b

        let whiteness = min(r, min(g, b))
        r -= whiteness
        g -= whiteness
        b -= whiteness

        let mg = max(r, max(g, b))

        var y = min(r, g)
        r -= y
        g -= y

        if b > 0 && g > 0 {
            b /= 2.0
            g /= 2.0
        }

        y += g
        b += g

        let my = max(r, max(y, b))
        if my > 0 {
            let n = mg / my
            r *= n
            y *= n
            b *= n
        }

        r += whiteness
        y += whiteness
        b += whiteness

        return (r: r, y: y, b: b, a: components.a)
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: cmyka
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    public var cmyka : (c: CGFloat, m: CGFloat, y: CGFloat, k: CGFloat, a: CGFloat) {
        var c : CGFloat = 0
        var y : CGFloat = 0
        var m : CGFloat = 0
        var k : CGFloat = 0

        let components = self.rgba
        let r = components.r
        let g = components.g
        let b = components.b

        k = min(1.0-r, min(1.0-g, 1.0-b));
        if k < 1.0  {
            c = (1.0-r-k)/(1.0-k);
            m = (1.0-g-k)/(1.0-k);
            y = (1.0-b-k)/(1.0-k);
        }

        return (c: c, m: m, y: y, k: k, a: components.a)
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: hsba
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    public var hsba : (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        var h : CGFloat = 0
        var s : CGFloat = 0
        var b : CGFloat = 0
        var a : CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h:h, s:s, b:b, a:a)
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: lumens
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    public var lumens : CGFloat {
        let v = self.rgba
        let lum = 0.2126 * v.r + 0.7152 * v.g + 0.0722 * v.b;
        return lum
    }

    public var rgbaColor : AppleColor {
        let alpha         = self.cgColor.alpha
        let opaqueColor   = self.cgColor.copy(alpha: 1.0)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let components    = rgbColorSpace.numberOfComponents
        let rgba          = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: components)
        let ref           = CGContext(data: nil , width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        ref!.setFillColor(opaqueColor!)
        ref!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))

        let r = CGFloat(rgba[0]) / 255.0
        let g = CGFloat(rgba[0]) / 255.0
        let b = CGFloat(rgba[0]) / 255.0

        return AppleColor(red: r, green: g, blue: b, alpha: alpha)
    }

    public var rgbColor : AppleColor {
        let colorSpace      = CGColorSpaceCreateDeviceRGB()
        let colorSpaceModel = colorSpace.model
        let cgColor         = self.cgColor
        let cgColorSpace    = cgColor.colorSpace

        if cgColorSpace!.model.rawValue == colorSpaceModel.rawValue {
            return self
        }

        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return AppleColor(red: red, green: green, blue: blue, alpha: alpha)

    }
}


#endif