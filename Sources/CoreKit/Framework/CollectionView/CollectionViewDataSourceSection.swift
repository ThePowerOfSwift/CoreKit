//
//  CollectionViewSourceSection.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2015. 12. 19..
//  Copyright © 2015. Tibor Bodecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import Foundation


public class CollectionViewDataSourceSection {

    public var grid: Grid?
    public var header: CollectionViewDataType?
    public var footer: CollectionViewDataType?
    public var items: [CollectionViewDataType]
    public var callback: ((CollectionViewObject, IndexPath) -> Void)?

    public init(grid: Grid? = nil,
                header: CollectionViewDataType? = nil,
                footer: CollectionViewDataType? = nil,
                items: [CollectionViewDataType] = [],
                callback: ((CollectionViewObject, IndexPath) -> Void)? = nil) {
        self.grid     = grid
        self.header   = header
        self.footer   = footer
        self.items    = items
        self.callback = callback
    }

}

#endif
