//
//  CollectionViewItem.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)
    
    import CoreGraphics.CGGeometry

    
    open class CollectionViewItem: AppleCollectionViewItem {
        
        #if os(iOS)
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.initialize()
        }
        #endif
        #if os(macOS)
        public override init(nibName nibNameOrNil: AppleNib.Name?, bundle nibBundleOrNil: AppleBundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
            self.initialize()
        }
        #endif

        public required init?(coder aDecoder: AppleCoder) {
            super.init(coder: aDecoder)
            
            self.initialize()
        }

        /**
         Generic initializer
         */
        open func initialize() {
            
        }
        
        open override func awakeFromNib() {
            super.awakeFromNib()
            
            self.reset()
        }
        
        open override func prepareForReuse() {
            super.prepareForReuse()
            
            self.reset()
        }
        
        /**
         Generic reset method
         */
        open func reset() {
            
        }
    }
    
#endif
