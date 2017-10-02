//
//  View.swift
//  CoreKit-iOS
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


#if os(iOS) || os(tvOS) || os(macOS)

    import CoreGraphics
    

    public class View: AppleView {
        
        public init() {
            super.init(frame: .zero)
            
            self.initialize()
        }
        
        private override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.initialize()
        }

        public required init?(coder aDecoder: AppleCoder) {
            super.init(coder: aDecoder)
            
            self.initialize()
        }
        
        /**
         Public override point for initialization
         */
        public func initialize() {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
}

#endif

