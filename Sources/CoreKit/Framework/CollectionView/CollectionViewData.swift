//
//  CollectionViewData.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2015. 12. 12..
//  Copyright © 2015. Tibor Bodecs. All rights reserved.
//


#if os(iOS) || os(tvOS) || os(macOS)

import Foundation
import CoreGraphics


public protocol CollectionViewDataType {

    func itemValue() -> CollectionViewObject
    func cellType() -> CollectionViewCell.Type

    func config(cell: CollectionViewCell, object: CollectionViewObject, indexPath: IndexPath, grid: Grid)
    func size(object: CollectionViewObject, indexPath: IndexPath, grid: Grid) -> CGSize
    func didSelect(object: CollectionViewObject, indexPath: IndexPath) -> Bool
}

open class CollectionViewData<C, I>: CollectionViewDataType where C: CollectionViewCell, I: CollectionViewObject {

    public var cell: C.Type
    public var item: I

    public var config: ((C, I, IndexPath, Grid) -> Void)?
    public var size: ((I, IndexPath, Grid) -> CGSize)?
    public var callback: ((I, IndexPath) -> Void)?
    
//    public weak var delegate: CollectionViewDataDelegate?

    public init(item: I,
                config: ((C, I, IndexPath, Grid) -> Void)?,
                size: ((I, IndexPath, Grid) -> CGSize)?,
                callback: ((I, IndexPath) -> Void)?)
    {
        self.cell     = C.self
        self.item     = item
        self.config   = config
        self.size     = size
        self.callback = callback

        self.initialize()
    }

    public convenience init(item: I,
                            config: ((C, I, IndexPath, Grid) -> Void)?,
                            size: ((I, IndexPath, Grid) -> CGSize)?)
    {
        self.init(item: item, config: config, size: size, callback: nil)
    }

    public convenience init(item: I) {
        self.init(item: item, config: nil, size: nil, callback: nil)
    }

    
    public func itemValue() -> CollectionViewObject {
        return self.item
    }

    public func cellType() -> CollectionViewCell.Type {
        return self.cell
    }

    public func didSelect(object: CollectionViewObject, indexPath: IndexPath) -> Bool {
        if let object = object as? I {
            self.didSelect(object: object, indexPath: indexPath)

            if let callback = self.callback {
                callback(object, indexPath)
                return true
            }
        }
        return false
    }

    public func config(cell: CollectionViewCell, object: CollectionViewObject, indexPath: IndexPath, grid: Grid) {
        if let object = object as? I, let cell = cell as? C {
            self.config(cell: cell, item: item, indexPath: indexPath, grid: grid)
            self.config?(cell, object, indexPath, grid)
        }
    }

    public func size(object: CollectionViewObject, indexPath: IndexPath, grid: Grid) -> CGSize {
        if let object = object as? I {
            if let callback = self.size {
                return callback(object, indexPath, grid)
            }
            return self.size(object: object, indexPath: indexPath, grid: grid)
        }
        return .zero
    }

    
    open func initialize() {
        
    }

    open func config(cell: C, item: I, indexPath: IndexPath, grid: Grid) {
        
    }
    
    open func size(object: I, indexPath: IndexPath, grid: Grid) -> CGSize {
        return .zero
    }
    
    open func didSelect(object: I, indexPath: IndexPath) {
        
    }
}

#endif
