//
//  AppleFont+Em.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
    
    import CoreGraphics

#if os(macOS)
    import AppKit.NSFontManager
#endif
    

    public extension AppleFont {
        
        // -
        // check for em details:
        // http://websemantics.co.uk/resources/font_size_conversion_chart/
        // -
        
        public func em(scale: CGFloat) -> AppleFont {
            let newSize = self.pointSize * scale
            
            #if os(iOS) || os(tvOS) || os(watchOS)
                return self.withSize(newSize)
            #endif
            #if os(macOS)
                return NSFontManager.shared.convert(self, toSize: newSize)
            #endif
        }
        
        public var em_0_5: AppleFont { return self.em(scale: 0.5) }
        public var em_0_55: AppleFont { return self.em(scale: 0.55) }
        public var em_0_625: AppleFont { return self.em(scale: 0.625) }
        public var em_0_7: AppleFont { return self.em(scale: 0.7) }
        public var em_0_75: AppleFont { return self.em(scale: 0.75) }
        public var em_0_8: AppleFont { return self.em(scale: 0.8) }
        public var em_0_875: AppleFont { return self.em(scale: 0.875) }
        public var em_0_95: AppleFont { return self.em(scale: 0.95) }
        public var em_1_05: AppleFont { return self.em(scale: 1.05) }
        public var em_1_125: AppleFont { return self.em(scale: 1.125) }
        public var em_1_2: AppleFont { return self.em(scale: 1.2) }
        public var em_1_25: AppleFont { return self.em(scale: 1.25) }
        public var em_1_3: AppleFont { return self.em(scale: 1.3) }
        public var em_1_4: AppleFont { return self.em(scale: 1.4) }
        public var em_1_45: AppleFont { return self.em(scale: 1.45) }
        public var em_1_5: AppleFont { return self.em(scale: 1.5) }
        public var em_1_6: AppleFont { return self.em(scale: 1.6) }
        public var em_1_8: AppleFont { return self.em(scale: 1.8) }
        public var em_2: AppleFont { return self.em(scale: 2) }
        public var em_2_2: AppleFont { return self.em(scale: 2.2) }
        public var em_2_25: AppleFont { return self.em(scale: 2.25) }
        public var em_2_3: AppleFont { return self.em(scale: 2.3) }
        public var em_2_35: AppleFont { return self.em(scale: 2.35) }
        public var em_2_45: AppleFont { return self.em(scale: 2.45) }
        public var em_2_55: AppleFont { return self.em(scale: 2.55) }
        public var em_2_75: AppleFont { return self.em(scale: 2.75) }
        public var em_3: AppleFont { return self.em(scale: 3) }
        public var em_4: AppleFont { return self.em(scale: 4) }
        public var em_5: AppleFont { return self.em(scale: 5) }
    }
    
#endif
