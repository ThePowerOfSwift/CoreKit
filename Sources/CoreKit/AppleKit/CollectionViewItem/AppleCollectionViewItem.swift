//
//  AppleCollectionViewItem.swift
//  CoreKit-iOS
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
    import UIKit.UICollectionView

    public typealias AppleCollectionViewItem = UICollectionViewCell
    
#elseif os(macOS)
    
    import AppKit.NSCollectionView
    
    public typealias AppleCollectionViewItem = NSCollectionViewItem
    
#endif

