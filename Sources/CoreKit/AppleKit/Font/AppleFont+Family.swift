//
//  AppleFont+Family.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
    
#if os(macOS)
    import AppKit.NSFontManager
#endif
    
    public extension AppleFont {
        
        public static var availableFamilies: [String] {
            #if os(iOS) || os(tvOS) || os(watchOS)
                return AppleFont.familyNames
            #endif
            #if os(macOS)
                return NSFontManager.shared.availableFontFamilies
            #endif
        }

        public static func availableFonts(forFamilyName family: String) -> [String] {
            #if os(iOS) || os(tvOS) || os(watchOS)
                return AppleFont.fontNames(forFamilyName: family)
            #endif
            #if os(macOS)
                var names: [String] = []
                for member in NSFontManager.shared.availableMembers(ofFontFamily: family) ?? [] {
                    if let name = member.first as? String {
                        names.append(name)
                    }
                }
                return names
            #endif
        }
        
        public static var availableFonts: [String] {
            var names: [String] = []
            #if os(iOS) || os(tvOS) || os(watchOS)
                for family in AppleFont.familyNames {
                    for name in AppleFont.fontNames(forFamilyName: family) {
                        names.append(name)
                    }
                }
            #endif
            #if os(macOS)
                for family in NSFontManager.shared.availableFontFamilies {
                    for member in NSFontManager.shared.availableMembers(ofFontFamily: family) ?? [] {
                        if let name = member.first as? String {
                            names.append(name)
                        }
                    }
                }
            #endif
            return names
        }
        
        
    }
#endif

