//
//  AppleColor+Hex.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics
import Foundation.NSScanner


public extension AppleColor {

    /**
     Initializes a color object from an integer type (hex value)
     
     - parameter hex:   The hexa code of the color
     - parameter alpha: The alpha value of the color
     - returns: The color object
     */
    public convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red   = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue  = CGFloat((hex & 0xFF)) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     Initializes a color object from a hexa string type
     
     - parameter hex:   The hexa code of the color
     - parameter alpha: The alpha value of the color
     - returns: The color object
     */
    public convenience init(hex string: String, alpha: CGFloat = 1.0) {
        var hex = string.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }
        
        if hex.characters.count < 3  {
            hex = hex + hex + hex
        }

        if hex.range(of: "(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .regularExpression) != nil {
            if hex.characters.count == 3 {
                
                let startIndex = hex.index(hex.startIndex, offsetBy: 1)
                let endIndex   = hex.index(hex.startIndex, offsetBy: 2)
                
                
                let redHex     = String(hex[..<startIndex])
                let greenHex   = String(hex[startIndex..<endIndex])
                let blueHex    = String(hex[endIndex...])
                
                hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
            }
            
            let startIndex = hex.index(hex.startIndex, offsetBy: 2)
            let endIndex   = hex.index(hex.startIndex, offsetBy: 4)
            let redHex     = String(hex[..<startIndex])
            let greenHex   = String(hex[startIndex..<endIndex])
            let blueHex    = String(hex[endIndex...])
            
            var redInt:   CUnsignedInt = 0
            var greenInt: CUnsignedInt = 0
            var blueInt:  CUnsignedInt = 0
            
            Scanner(string: redHex).scanHexInt32(&redInt)
            Scanner(string: greenHex).scanHexInt32(&greenInt)
            Scanner(string: blueHex).scanHexInt32(&blueInt)
            
            self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: CGFloat(alpha))
        }
        else {
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        }
    }
    
    /**
     Returns the color value in a hexa string format
     */
    var hexValue: String {
        var color = self
        
        if color.cgColor.numberOfComponents < 4 {
            let c = color.cgColor.components
            color = AppleColor(red: (c?[0])!, green: (c?[0])!, blue: (c?[0])!, alpha: (c?[1])!)
        }
        if color.cgColor.colorSpace!.model != .rgb {
            return "#FFFFFF"
        }
        let c = color.cgColor.components
        return String(format: "#%02X%02X%02X", Int(c![0]*255.0), Int(c![1]*255.0), Int(c![2]*255.0))
    }
    
}

