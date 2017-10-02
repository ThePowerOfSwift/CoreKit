//
//  CollectionViewData.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)
    
    import CoreGraphics.CGGeometry

    
    public protocol CollectionViewDataProtocol {
        
        var item: CollectionViewItem.Type { get }
        var value: Any { get }
        
        func config(item: CollectionViewItem, data: Any, indexPath: AppleIndexPath, grid: Grid)
        func size(data: Any, indexPath: AppleIndexPath, grid: Grid) -> CGSize
        func callback(data: Any, indexPath: AppleIndexPath) -> Bool
    }

    
    open class CollectionViewData<Item, Data>: CollectionViewDataProtocol where Item: CollectionViewItem, Data: Any {

        public typealias ConfigBlock = (Item, Data, AppleIndexPath, Grid) -> Void
        public typealias SizeBlock = (Data, AppleIndexPath, Grid) -> CGSize
        public typealias CallbackBlock = (Data, AppleIndexPath) -> Bool

        public var item: CollectionViewItem.Type { return Item.self }
        public var value: Any { return self.data }
 
        public var data: Data
        public var config: ConfigBlock?
        public var size: SizeBlock?
        public var callback: CallbackBlock?
        

        public init(_ data: Data, config: ConfigBlock?, size: SizeBlock?, callback: CallbackBlock?) {
            self.data = data
            self.config = config
            self.size = size
            self.callback = callback
            
            self.initialize()
        }
        
        public convenience init(_ data: Data, config: ConfigBlock?, size: SizeBlock?) {
            self.init(data, config: config, size: size, callback: nil)
        }
        
        public convenience init(_ data: Data) {
            self.init(data, config: nil, size: nil, callback: nil)
        }
        
        open func initialize() {
            
        }
        
        
        public func config(item: CollectionViewItem, data: Any, indexPath: AppleIndexPath, grid: Grid) {
            guard let data = data as? Data, let item = item as? Item else {
                return
            }
            if let config = self.config {
                return config(item, data, indexPath, grid)
            }
            return self.config(item: item, data: data, indexPath: indexPath, grid: grid)
        }
        
        open func config(item: Item, data: Data, indexPath: AppleIndexPath, grid: Grid) {
            
        }
        
        
        public func size(data: Any, indexPath: AppleIndexPath, grid: Grid) -> CGSize {
            guard let data = data as? Data else {
                return .zero
            }
            if let callback = self.size {
                return callback(data, indexPath, grid)
            }
            return self.size(data: data, indexPath: indexPath, grid: grid)
        }
        
        open func size(data: Data, indexPath: AppleIndexPath, grid: Grid) -> CGSize {
            return .zero
        }

        
        public func callback(data: Any, indexPath: AppleIndexPath) -> Bool {
            guard let data = data as? Data else {
                return false
            }
            if let callback = self.callback {
                return callback(data, indexPath)
            }
            return self.callback(data: data, indexPath: indexPath)
        }
        
        open func callback(data: Data, indexPath: AppleIndexPath) -> Bool {
            return false
        }
    }
    
#endif

