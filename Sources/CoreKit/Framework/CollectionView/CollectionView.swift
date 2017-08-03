//
//  CollectionView.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2015. 12. 12..
//  Copyright © 2015. Tibor Bodecs. All rights reserved.
//

import Foundation


#if os(iOS)
import CoreGraphics


// MARK: - <#Description#>
public extension AppleCollectionView {


    /// <#Description#>
    ///
    /// - parameter layout: <#layout description#>
    ///
    /// - returns: <#return value description#>
    public convenience init(layout: AppleCollectionViewFlowLayout) {

        self.init(frame: CGRect.zero, collectionViewLayout: layout)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.alwaysBounceVertical                      = true
        self.backgroundColor                           = AppleColor.clear
    }
}
#endif

#if os(iOS) || os(tvOS) || os(macOS)

/// <#Description#>
open class CollectionView: AppleCollectionView {


    /// <#Description#>
    open var source: CollectionViewDataSource? = nil {
        didSet {

            self.source?.registerViews(self)

            self.dataSource = self.source
            self.delegate   = self.source
        }
    }
    #if os(iOS)

    /// <#Description#>
    open var showsScrollIndicators: Bool {
        get {
            return self.showsHorizontalScrollIndicator || self.showsVerticalScrollIndicator
        }
        set {
            self.showsHorizontalScrollIndicator = newValue
            self.showsVerticalScrollIndicator = newValue
        }
    }
    #endif
}

#if os(iOS)

// MARK: - <#Description#>
public extension CollectionView {

    func transformTo(_ source: CollectionViewDataSource) {
        self.performBatchUpdates({
            if let indexes = self.source?.sectionIndexes {
                self.deleteSections(indexes as IndexSet)
            }
            self.source = source
            if let indexes = source.sectionIndexes {
                self.insertSections(indexes as IndexSet)
            }

        }, completion: { (finished) -> Void in
            // do nothing...
        })
    }

}
#endif
#endif
