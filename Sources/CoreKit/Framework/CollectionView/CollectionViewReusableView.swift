//
//  CollectionViewReusableView.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2016. 03. 29..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//


#if os(iOS) || os(tvOS) || os(macOS)

import Foundation
    
#if os(macOS)
    import AppKit
#endif

public extension AppleCollectionViewReusableView {

    public class func registerForAllKind(_ collectionView: AppleCollectionView) {
        self.register(collectionView)

        self.register(collectionView, kind: AppleCollectionElementKindSectionHeader)
        self.register(collectionView, kind: AppleCollectionElementKindSectionFooter)
    }
}


public extension AppleCollectionViewReusableView {

    public class func registerNib(_ collectionView: AppleCollectionView) {
        #if os(iOS) || os(tvOS)
            collectionView.register(self.nib, forCellWithReuseIdentifier: self.uniqueIdentifier)
        #elseif os(macOS)
            
            collectionView.register(self.nib, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier))
        #endif
    }

    public class func registerClass(_ collectionView: AppleCollectionView) {
        #if os(iOS) || os(tvOS)
            collectionView.register(self, forCellWithReuseIdentifier: self.uniqueIdentifier)
        #elseif os(macOS)
            collectionView.register(self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier))
        #endif
    }

    public class func register(_ collectionView: AppleCollectionView) {
        if self.nib != nil {
            return self.registerNib(collectionView)
        }
        self.registerClass(collectionView)
    }

    public class func reuse(_ collectionView: AppleCollectionView,
                                   indexPath: IndexPath) -> AppleCollectionViewCell
    {
        #if os(iOS) || os(tvOS)
            return collectionView.dequeueReusableCell(withReuseIdentifier: self.uniqueIdentifier, for: indexPath)
        #elseif os(macOS)
            return collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier), for: indexPath)
        #endif
    }

}


public extension AppleCollectionViewReusableView
{
    #if os(macOS)
    private class func _register(_ collectionView: AppleCollectionView, kind: String) {
        
        collectionView.register(AppleView.self, forSupplementaryViewOfKind: NSCollectionView.SupplementaryElementKind(rawValue: kind),
                                                            withIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier))
    }
    #endif

    public class func registerNib(_ collectionView: AppleCollectionView, kind: String) {
        #if os(iOS) || os(tvOS)
            collectionView.register(self.nib, forSupplementaryViewOfKind: kind,
                                                     withReuseIdentifier: self.uniqueIdentifier)
        #elseif os(macOS)
            self._register(collectionView, kind: kind)
            collectionView.register(self.nib, forSupplementaryViewOfKind: NSCollectionView.SupplementaryElementKind(rawValue: kind),
                                                          withIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier))
        #endif
    }

    public class func registerClass(_ collectionView: AppleCollectionView, kind: String) {
        #if os(iOS) || os(tvOS)
            collectionView.register(self, forSupplementaryViewOfKind: kind,
                                                 withReuseIdentifier: self.uniqueIdentifier)
        #elseif os(macOS)
            self._register(collectionView, kind: kind)
            collectionView.register(self, forSupplementaryViewOfKind: NSCollectionView.SupplementaryElementKind(rawValue: kind),
                                                      withIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier))
        #endif
    }

    public class func register(_ collectionView: AppleCollectionView, kind: String) {
        if self.nib != nil {
            return self.registerNib(collectionView, kind: kind)
        }
        self.registerClass(collectionView, kind: kind)
    }


    public class func reuse(_ collectionView: AppleCollectionView,
                                   indexPath: IndexPath,
                                        kind: String) -> AppleCollectionViewReusableView
    {
        #if os(iOS) || os(tvOS)
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                      withReuseIdentifier: self.uniqueIdentifier,
                                                                      for: indexPath)
        #elseif os(macOS)
            
            let wrapper = self.init(nibName: NSNib.Name(rawValue: self.uniqueIdentifier), bundle: .main)

            let view = collectionView.makeSupplementaryView(ofKind: NSCollectionView.SupplementaryElementKind(rawValue: kind),
                                                    withIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier),
                                                               for: indexPath)

            view.subviews.forEach { $0.removeFromSuperview() }

            wrapper.view.frame = view.bounds

            view.addSubview(wrapper.view)

            return wrapper
        #endif
    }

}
#endif
