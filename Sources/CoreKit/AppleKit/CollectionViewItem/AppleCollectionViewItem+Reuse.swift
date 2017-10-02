//
//  AppleCollectionViewItem+Reuse.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


#if os(iOS) || os(tvOS) || os(macOS)
    
    #if os(macOS)
        import AppKit
    #endif
        
    import Foundation.NSIndexPath

//    alternative solution for cell registration... worth to consider because of the type casts
//    public protocol AppleCollectionViewReusableViewItem {}
//
//    extension AppleCollectionViewItem: AppleCollectionViewReusableViewItem {}
//
//    class MyItem: AppleCollectionViewItem {
//
//    }
//
//    public extension AppleCollectionView {
//
//        public func registerReusableItem<T: AppleCollectionViewItem>(_: T.Type) where T: AppleCollectionViewReusableViewItem {
//            if let nib = T.nib {
//                return self.register(nib, forCellWithReuseIdentifier: T.uniqueIdentifier)
//            }
//            self.register(T.self, forCellWithReuseIdentifier: T.uniqueIdentifier)
//        }
//
//        public func test() {
//
//            AppleCollectionView().registerReusableItem(MyItem.self)
//        }
//    }
    
    
    public extension AppleCollectionViewItem {
        
        public static func register(allKindsFor collectionView: AppleCollectionView) {
            self.register(for: collectionView)

            self.register(collectionView, kind: AppleCollectionElementKindSectionHeader)
            self.register(collectionView, kind: AppleCollectionElementKindSectionFooter)
        }
    }

    public extension AppleCollectionViewItem {

        public static func register(nibFor collectionView: AppleCollectionView) {
            #if os(iOS) || os(tvOS)
                collectionView.register(self.nib, forCellWithReuseIdentifier: self.uniqueIdentifier)
            #elseif os(macOS)
                collectionView.register(self.nib, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier))
            #endif
        }
        
        public static func register(classFor collectionView: AppleCollectionView) {
            #if os(iOS) || os(tvOS)
                collectionView.register(self, forCellWithReuseIdentifier: self.uniqueIdentifier)
            #elseif os(macOS)
                collectionView.register(self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier))
            #endif
        }

        public static func register(for collectionView: AppleCollectionView) {
            if self.nib != nil {
                return self.register(nibFor: collectionView)
            }
            self.register(classFor: collectionView)
        }
        
        public static func reuse(_ collectionView: AppleCollectionView, indexPath: IndexPath) -> AppleCollectionViewItem {
            #if os(iOS) || os(tvOS)
                return collectionView.dequeueReusableCell(withReuseIdentifier: self.uniqueIdentifier, for: indexPath)
            #elseif os(macOS)
                return collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier), for: indexPath)
            #endif
        }
        
    }
    
    
    public extension AppleCollectionViewItem {
        #if os(macOS)
        private static func _register(_ collectionView: AppleCollectionView, kind: String) {
        
        collectionView.register(AppleView.self, forSupplementaryViewOfKind: NSCollectionView.SupplementaryElementKind(rawValue: kind),
        withIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier))
        }
        #endif
        
        public static func registerNib(_ collectionView: AppleCollectionView, kind: String) {
            #if os(iOS) || os(tvOS)
                collectionView.register(self.nib, forSupplementaryViewOfKind: kind,
                                        withReuseIdentifier: self.uniqueIdentifier)
            #elseif os(macOS)
                self._register(collectionView, kind: kind)
                collectionView.register(self.nib, forSupplementaryViewOfKind: NSCollectionView.SupplementaryElementKind(rawValue: kind),
                                        withIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier))
            #endif
        }
        
        public static func registerClass(_ collectionView: AppleCollectionView, kind: String) {
            #if os(iOS) || os(tvOS)
                collectionView.register(self, forSupplementaryViewOfKind: kind,
                                        withReuseIdentifier: self.uniqueIdentifier)
            #elseif os(macOS)
                self._register(collectionView, kind: kind)
                collectionView.register(self, forSupplementaryViewOfKind: NSCollectionView.SupplementaryElementKind(rawValue: kind),
                                        withIdentifier: NSUserInterfaceItemIdentifier(rawValue: self.uniqueIdentifier))
            #endif
        }
        
        public static func register(_ collectionView: AppleCollectionView, kind: String) {
            if self.nib != nil {
                return self.registerNib(collectionView, kind: kind)
            }
            self.registerClass(collectionView, kind: kind)
        }

        public static func reuse(_ collectionView: AppleCollectionView,
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
