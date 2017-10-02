//
//  AppleCollectionView+Init.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


#if os(iOS) || os(tvOS)
    
    public extension AppleCollectionView {
    
        /**
         Initializes a CollectionView object with a frame zero, autolayout enabled
         
         - parameter layout: The layout to initialize with defaults to UICollectionViewFlowLayout()
         - returns: The UICollectionView object
         */
        public convenience init(layout: AppleCollectionViewLayout = AppleCollectionViewFlowLayout(),
                                autolayout: Bool = true,
                                backgroundColor: AppleColor = .clear)
        {
            self.init(frame: .zero, collectionViewLayout: layout)

            self.translatesAutoresizingMaskIntoConstraints = autolayout
            self.backgroundColor = backgroundColor
        }
    }

#endif
