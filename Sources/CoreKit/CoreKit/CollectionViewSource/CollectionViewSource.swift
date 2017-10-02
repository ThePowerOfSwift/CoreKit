//
//  CollectionViewSource.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)
    
    import CoreGraphics.CGGeometry


    open class CollectionViewSource: AppleObject {
        
        private var indexPathSelected = false

        open var selectionThreshold: Double = 0.5
        open var itemsToRegister = [CollectionViewItem.self]
        open var grid: Grid
        open var sections: [CollectionViewSection] = []
        open var callback: CollectionViewCallback?

        public init(grid: Grid) {
            self.grid = grid
            
            super.init()
        }
    }

    public extension CollectionViewSource {
        
        public var sectionIndexes: AppleIndexSet? {
            if self.sections.isEmpty {
                return nil
            }
            if self.sections.count == 1 {
                return AppleIndexSet(integer: 0)
            }
            return AppleIndexSet(integersIn: 0..<self.sections.count-1)
        }
    }
    
    public extension CollectionViewSource {
        
        public func itemAt(_ section: Int) -> CollectionViewSection? {
            return self.sections.element(at: section)
        }
        
        public func itemAt(_ indexPath: AppleIndexPath) -> CollectionViewDataProtocol? {
            return self.itemAt(indexPath.section)?.items.element(at: indexPath.item)
        }
    }
    
    public extension CollectionViewSource {
        
        public func register(itemsFor collectionView: CollectionView) {
            
            for view in self.itemsToRegister {
                view.register(allKindsFor: collectionView)
            }
            
            for sectionData in self.sections {
                if let view = sectionData.header?.item {
                    view.register(allKindsFor: collectionView)
                }
                if let view = sectionData.footer?.item {
                    view.register(allKindsFor: collectionView)
                }
                for view in sectionData.items.map({ $0.item }) {
                    view.register(allKindsFor: collectionView)
                }
            }
        }
    }
    
    
    extension CollectionViewSource: AppleCollectionViewSource {
        
        public func numberOfSections(in collectionView: AppleCollectionView) -> Int {
            return self.sections.count
        }
        
        public func collectionView(_ collectionView: AppleCollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.itemAt(section)?.items.count ?? 0
        }

        private func collectionView(_ collectionView: AppleCollectionView, itemForIndexPath indexPath: AppleIndexPath) -> AppleCollectionViewItem {
            guard
                let data = self.itemAt(indexPath),
                let item = data.item.reuse(collectionView, indexPath: indexPath) as? CollectionViewItem
            else {
                return CollectionViewItem.reuse(collectionView, indexPath: indexPath)
            }
            data.config(item: item, data: data.value, indexPath: indexPath, grid: self.grid(indexPath.section))
            return item
        }
        
        #if os(iOS) || os(tvOS)
        public func collectionView(_ collectionView: AppleCollectionView, cellForItemAt indexPath: AppleIndexPath) -> AppleCollectionViewItem {
            return self.collectionView(collectionView, itemForIndexPath: indexPath)
        }
        #elseif os(macOS)
        public func collectionView(_ collectionView: AppleCollectionView, itemForRepresentedObjectAt indexPath: AppleIndexPath) -> AppleCollectionViewItem {
            return self.collectionView(collectionView, itemForIndexPath: indexPath)
        }
        #endif
        
        private func _collectionView(_ collectionView: AppleCollectionView,
                                     viewForSupplementaryElementOfKind kind: String,
                                     at indexPath: AppleIndexPath) -> AppleCollectionViewReusableView
        {
            let grid = self.grid(indexPath.section)
            let section = self.itemAt(indexPath.section)

            if kind == AppleCollectionElementKindSectionHeader {
                guard
                    let section = section,
                    let data = section.header,
                    let cell = data.item.reuse(collectionView, indexPath: indexPath, kind: kind) as? CollectionViewItem
                else {
                    return CollectionViewItem.reuse(collectionView, indexPath: indexPath)
                }
                data.config(item: cell, data: data.value, indexPath: indexPath, grid: grid)
                return cell
            }
            
            if kind == AppleCollectionElementKindSectionFooter {
                guard
                    let section = section,
                    let data = section.footer,
                    let cell = data.item.reuse(collectionView, indexPath: indexPath, kind: kind) as? CollectionViewItem
                else {
                    return CollectionViewItem.reuse(collectionView, indexPath: indexPath)
                }
                data.config(item: cell, data: data.value, indexPath: indexPath, grid: grid)
                return cell
            }

            return CollectionViewItem.reuse(collectionView, indexPath: indexPath, kind: kind)
        }
        
        #if os(iOS) || os(tvOS)
        public func collectionView(_ collectionView: AppleCollectionView,
                                   viewForSupplementaryElementOfKind kind: String,
                                   at indexPath: AppleIndexPath) -> AppleCollectionViewReusableView
        {
            return self._collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        }
        #elseif os(macOS)
        public func collectionView(_ collectionView: AppleCollectionView,
                                   viewForSupplementaryElementOfKind kind: String,
                                   at indexPath: AppleIndexPath) -> AppleView
        {
            let reusedView = self._collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
            return reusedView.view.superview!
        }
        #endif
        
        public func collectionView(_ collectionView: AppleCollectionView,
                                   canMoveItemAt indexPath: AppleIndexPath) -> Bool
        {
            return false
        }
        
        public func collectionView(_ collectionView: AppleCollectionView,
                                   moveItemAt sourceIndexPath: AppleIndexPath,
                                   to destinationIndexPath: AppleIndexPath) {
            //        guard let _ = self.dataAt(sourceIndexPath) else { return }
        }
    }
    
    
    extension CollectionViewSource: AppleCollectionViewDelegate {
        
        func selectItem(at indexPath: AppleIndexPath) {
            guard let data = self.itemAt(indexPath), !self.indexPathSelected else { return }
            
            if self.selectionThreshold > 0 {
                self.indexPathSelected = true
                
                DispatchQueue.main.asyncAfter(delay: self.selectionThreshold) { [weak self] in
                    self?.indexPathSelected = false
                }
            }
            
            if !data.callback(data: data.value, indexPath: indexPath) {
                if let section = self.itemAt(indexPath.section), let callback = section.callback {
                    return callback(data.value, indexPath)
                }
                self.callback?(data.value, indexPath)
            }
        }
        
        public func collectionView(_ collectionView: AppleCollectionView,
                                   didSelectItemAt indexPath: AppleIndexPath)
        {
            self.selectItem(at: indexPath)
        }
        
        public func collectionView(_ collectionView: AppleCollectionView,
                                   willDisplay cell: AppleCollectionViewItem,
                                   forItemAt indexPath: AppleIndexPath)
        {
            //        guard let _ = self.dataAt(indexPath) else { return }
        }
        
        #if os(macOS)
        public func collectionView(_ collectionView: AppleCollectionView,
                                   didSelectItemsAt indexPaths: Set<AppleIndexPath>)
        {
            collectionView.deselectItems(at: indexPaths)
            
            guard let indexPath = indexPaths.first else { return }
            
            self.selectItem(at: indexPath)
        }
        
        public func collectionView(_ collectionView: AppleCollectionView,
                                   didDeselectItemsAt indexPaths: Set<AppleIndexPath>)
        {
            //        guard let indexPath = indexPaths.first else {return}
            //        guard let item = collectionView.itemAtIndexPath(indexPath) else {return}
            //        (item as! CollectionViewItem).setHighlight(false)
        }
        #endif
    }

    extension CollectionViewSource: AppleCollectionViewDelegateFlowLayout {
        
        func grid(_ section: Int) -> Grid {
            return self.itemAt(section)?.grid ?? self.grid
        }
        
        public func collectionView(_ collectionView: AppleCollectionView,
                                   layout collectionViewLayout: AppleCollectionViewLayout,
                                   sizeForItemAt indexPath: AppleIndexPath) -> CGSize
        {
            guard let data = self.itemAt(indexPath) else {
                return .zero
            }
            return data.size(data: data.value, indexPath: indexPath, grid: self.grid(indexPath.section))
        }
        
        public func collectionView(_ collectionView: AppleCollectionView,
                                   layout collectionViewLayout: AppleCollectionViewLayout,
                                   insetForSectionAt section: Int) -> AppleEdgeInsets
        {
            if let insets = self.grid(section).insets {
                return insets
            }
            let margin = self.grid(section).margin
            return AppleEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        }
        
        public func collectionView(_ collectionView: AppleCollectionView,
                                   layout collectionViewLayout: AppleCollectionViewLayout,
                                   minimumLineSpacingForSectionAt section: Int) -> CGFloat
        {
            if let spacing = self.grid(section).lineSpacing {
                return spacing
            }
            return self.grid(section).padding
        }
        
        public func collectionView(_ collectionView: AppleCollectionView,
                                   layout collectionViewLayout: AppleCollectionViewLayout,
                                   minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
        {
            if let spacing = self.grid(section).itemSpacing {
                return spacing
            }
            return self.grid(section).padding
        }
        
        public func collectionView(_ collectionView: AppleCollectionView,
                                   layout collectionViewLayout: AppleCollectionViewLayout,
                                   referenceSizeForHeaderInSection section: Int) -> CGSize
        {
            guard let data = self.itemAt(section)?.header else {
                return .zero
            }
            let indexPath = AppleIndexPath(item: -1, section: section)
            return data.size(data: data.value, indexPath: indexPath, grid: self.grid(section))
        }
        
        public func collectionView(_ collectionView: AppleCollectionView,
                                   layout collectionViewLayout: AppleCollectionViewLayout,
                                   referenceSizeForFooterInSection section: Int) -> CGSize
        {
            guard let data = self.itemAt(section)?.footer else {
                return .zero
            }
            let indexPath = AppleIndexPath(item: -1, section: section)
            return data.size(data: data.value, indexPath: indexPath, grid: self.grid(section))
        }
    }
    
#endif

