//
//    CollectionViewDataSource.swift
//    CoreKit
//
//    Created by Tibor Bodecs on 2015. 12. 12..
//    Copyright © 2015. Tibor Bodecs. All rights reserved.
//


#if os(iOS) || os(tvOS) || os(macOS)

import Foundation
import CoreGraphics

open class CollectionViewDataSource: NSObject {

    fileprivate var indexPathSelected = false

    open var selectionThreshold : TimeInterval = 0.5

    open var cellsToRegister = [CollectionViewCell.self]

    open var grid: Grid

    open var sections: [CollectionViewDataSourceSection] = []

    open var callback: ((CollectionViewObject, IndexPath) -> Void)?

    public init(grid: Grid) {
        self.grid = grid

        super.init()
    }
}

public extension CollectionViewDataSource {

    public var sectionIndexes: IndexSet? {
        if self.sections.isEmpty {
            return nil
        }
        if self.sections.count == 1 {
            return IndexSet(integer: 0)
        }
        return IndexSet(integersIn: 0..<self.sections.count-1)
    }
}

public extension CollectionViewDataSource {

    public func sectionAt(_ index: Int) -> CollectionViewDataSourceSection? {
        return self.sections.element(at: index)
    }

    public func dataAt(_ indexPath: IndexPath) -> CollectionViewDataType? {
        return self.sectionAt(indexPath.section)?.items.element(at: indexPath.item)
    }
}

public extension CollectionViewDataSource {

    public func registerViews(_ collectionView: CollectionView) {

        for view in self.cellsToRegister {
            view.registerForAllKind(collectionView)
        }

        for sectionData in self.sections {
            if let view = sectionData.header?.cellType() {
                view.registerForAllKind(collectionView)
            }
            if let view = sectionData.footer?.cellType() {
                view.registerForAllKind(collectionView)
            }
            for view in sectionData.items.map({ $0.cellType() }) {
                view.registerForAllKind(collectionView)
            }
        }
    }
}


extension CollectionViewDataSource: AppleCollectionViewDataSource {

    public func numberOfSections(in collectionView: AppleCollectionView) -> Int {
        return self.sections.count
    }

    public func collectionView(_ collectionView: AppleCollectionView,
                 numberOfItemsInSection section: Int) -> Int
    {
        return self.sectionAt(section)?.items.count ?? 0
    }

    private func collectionView(_ collectionView: AppleCollectionView,
                      cellForIndexPath indexPath: IndexPath) -> AppleCollectionViewCell
    {
        guard
            let data = self.dataAt(indexPath),
            let cell = data.cellType().reuse(collectionView, indexPath: indexPath) as? CollectionViewCell
        else {
            return CollectionViewCell.reuse(collectionView, indexPath: indexPath)
        }
        data.config(cell: cell, object: data.itemValue(), indexPath: indexPath, grid: self.grid(indexPath.section))
        return cell
    }

    #if os(iOS) || os(tvOS)
    public func collectionView(_ collectionView: AppleCollectionView,
                        cellForItemAt indexPath: IndexPath) -> AppleCollectionViewCell
    {
        return self.collectionView(collectionView, cellForIndexPath: indexPath)
    }
    #elseif os(macOS)
    public func collectionView(_ collectionView: AppleCollectionView,
           itemForRepresentedObjectAt indexPath: IndexPath) -> AppleCollectionViewCell
    {
        return self.collectionView(collectionView, cellForIndexPath: indexPath)
    }
    #endif

    private func _collectionView(_ collectionView: AppleCollectionView,
           viewForSupplementaryElementOfKind kind: String,
                                     at indexPath: IndexPath) -> AppleCollectionViewReusableView
    {
        typealias Cell = CollectionViewCell

        let section = self.sectionAt(indexPath.section)
        let grid     = self.grid(indexPath.section)

        if kind == AppleCollectionElementKindSectionHeader {
            guard
                let section = section,
                let data = section.header,
                let cell = data.cellType().reuse(collectionView, indexPath: indexPath, kind: kind) as? Cell
            else {
                    return Cell.reuse(collectionView, indexPath: indexPath)
            }
            data.config(cell: cell, object: data.itemValue(), indexPath: indexPath, grid: grid)
            return cell
        }

        if kind == AppleCollectionElementKindSectionFooter {
            guard
                let section = section,
                let data = section.footer,
                let cell = data.cellType().reuse(collectionView, indexPath: indexPath, kind: kind) as? Cell
            else {
                    return Cell.reuse(collectionView, indexPath: indexPath)
            }
            data.config(cell: cell, object: data.itemValue(), indexPath: indexPath, grid: grid)
            return cell
        }

        return Cell.reuse(collectionView, indexPath: indexPath, kind: kind)
    }

    #if os(iOS) || os(tvOS)
    public func collectionView(_ collectionView: AppleCollectionView,
         viewForSupplementaryElementOfKind kind: String,
                                   at indexPath: IndexPath) -> AppleCollectionViewReusableView
    {
        return self._collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
    #elseif os(macOS)
    public func collectionView(_ collectionView: AppleCollectionView,
         viewForSupplementaryElementOfKind kind: String,
                                   at indexPath: IndexPath) -> AppleView
    {

        let reusedView = self._collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        return reusedView.view.superview!
    }
    #endif

    public func collectionView(_ collectionView: AppleCollectionView,
                        canMoveItemAt indexPath: IndexPath) -> Bool
    {
        return false
    }

    public func collectionView(_ collectionView: AppleCollectionView,
                     moveItemAt sourceIndexPath: IndexPath,
                        to destinationIndexPath: IndexPath) {
        //        guard let _ = self.dataAt(sourceIndexPath) else { return }
    }
}


extension CollectionViewDataSource: AppleCollectionViewDelegate {

    func selectItem(at indexPath: IndexPath) {
        guard let data = self.dataAt(indexPath), !self.indexPathSelected else { return }
        
        if self.selectionThreshold > 0 {
            self.indexPathSelected = true
            let time = DispatchTime.now() + self.selectionThreshold
            DispatchQueue.main.asyncAfter(deadline: time, execute: { [weak self] in
                self?.indexPathSelected = false
            })
        }
        
        if !data.didSelect(object: data.itemValue(), indexPath: indexPath) {
            if let section = self.sectionAt(indexPath.section), let callback = section.callback {
                return callback(data.itemValue(), indexPath)
            }
            self.callback?(data.itemValue(), indexPath)
        }
    }

    public func collectionView(_ collectionView: AppleCollectionView,
                      didSelectItemAt indexPath: IndexPath)
    {
        self.selectItem(at: indexPath)
    }

    public func collectionView(_ collectionView: AppleCollectionView,
                               willDisplay cell: AppleCollectionViewCell,
                            forItemAt indexPath: IndexPath)
    {
        //        guard let _ = self.dataAt(indexPath) else { return }
    }

#if os(macOS)
    public func collectionView(_ collectionView: AppleCollectionView,
                               didSelectItemsAt indexPaths: Set<IndexPath>)
    {
        collectionView.deselectItems(at: indexPaths)

        guard let indexPath = indexPaths.first else { return }

        self.selectItem(at: indexPath)
    }

    public func collectionView(_ collectionView: AppleCollectionView,
                               didDeselectItemsAt indexPaths: Set<IndexPath>)
    {
        //        guard let indexPath = indexPaths.first else {return}
        //        guard let item = collectionView.itemAtIndexPath(indexPath) else {return}
        //        (item as! CollectionViewItem).setHighlight(false)
    }
#endif
}


extension CollectionViewDataSource: AppleCollectionViewDelegateFlowLayout {

    func grid(_ section: Int) -> Grid {
        return self.sectionAt(section)?.grid ?? self.grid
    }

    public func collectionView(_ collectionView: AppleCollectionView,
                    layout collectionViewLayout: AppleCollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        guard let data = self.dataAt(indexPath) else {
            return .zero
        }
        return data.size(object: data.itemValue(), indexPath: indexPath, grid: self.grid(indexPath.section))
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
        guard let data = self.sectionAt(section)?.header else {
            return .zero
        }
        let indexPath = IndexPath(item: -1, section: section)
        return data.size(object: data.itemValue(), indexPath: indexPath, grid: self.grid(section))
    }

    public func collectionView(_ collectionView: AppleCollectionView,
                    layout collectionViewLayout: AppleCollectionViewLayout,
        referenceSizeForFooterInSection section: Int) -> CGSize
    {
        guard let data = self.sectionAt(section)?.footer else {
            return .zero
        }
        let indexPath = IndexPath(item: -1, section: section)
        return data.size(object: data.itemValue(), indexPath: indexPath, grid: self.grid(section))
    }
}

#endif
