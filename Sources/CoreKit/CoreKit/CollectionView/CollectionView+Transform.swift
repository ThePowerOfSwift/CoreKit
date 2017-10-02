//
//  CollectionView+Transform.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS)
    
    import Foundation.NSIndexSet

    public extension CollectionView {
        
        func transformTo(_ source: CollectionViewSource) {
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
