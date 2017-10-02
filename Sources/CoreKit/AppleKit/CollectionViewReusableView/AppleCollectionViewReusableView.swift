//
//  AppleCollectionViewReusableView.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
    import UIKit.UICollectionView
    
    public typealias AppleCollectionViewReusableView = UICollectionReusableView
    
    public let AppleCollectionElementKindSectionHeader = UICollectionElementKindSectionHeader
    public let AppleCollectionElementKindSectionFooter = UICollectionElementKindSectionFooter
    
#elseif os(macOS)
    
    import AppKit.NSCollectionView

    public typealias AppleCollectionViewReusableView = NSCollectionViewItem
    
    public let AppleCollectionElementKindSectionHeader = NSCollectionView.SupplementaryElementKind.sectionHeader.rawValue
    public let AppleCollectionElementKindSectionFooter = NSCollectionView.SupplementaryElementKind.sectionFooter.rawValue
    
#endif


