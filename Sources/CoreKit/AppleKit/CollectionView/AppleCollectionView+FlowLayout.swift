//
//  AppleCollectionView+FlowLayout.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

public extension AppleCollectionView {
    /**
     The flow layout of the collection view
     */
    public var flowLayout: AppleCollectionViewFlowLayout? {
        return self.collectionViewLayout as? AppleCollectionViewFlowLayout
    }
}

#endif

