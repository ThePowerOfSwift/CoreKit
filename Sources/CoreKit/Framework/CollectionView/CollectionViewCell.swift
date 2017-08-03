//
//  CollectionViewCell.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2015. 12. 12..
//  Copyright © 2015. Tibor Bodecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import Foundation
import CoreGraphics

#if os(macOS)
    import AppKit.NSNib
#endif

open class CollectionViewCell: AppleCollectionViewCell {

    #if os(iOS)
    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.initialize()
    }
    #endif

    #if os(macOS)
    
    public override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.initialize()
    }
    #endif

    /**
     Init coder should call initialize.
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }

    /**
     Generic initializer
     */
    open func initialize() {

    }

    /**
     On awake reset cells
     */
    open override func awakeFromNib() {
        super.awakeFromNib()

        self.reset()
    }

    /**
     On reuse reset cells
     */
    open override func prepareForReuse() {
        super.prepareForReuse()

        self.reset()
    }

    /**
     Generic cell reset method
     */
    open func reset() {

    }

}
#endif
