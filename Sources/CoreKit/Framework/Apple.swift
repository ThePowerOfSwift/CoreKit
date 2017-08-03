//
//    Apple.swift
//    CoreKit
//
//    Created by Tibor Bodecs on 29/08/16.
//    Copyright © 2016 Tibor Bodecs. All rights reserved.
//


#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit.UIColor
    import UIKit.UIImage

    public typealias AppleColor                             = UIColor
    public typealias AppleImage                             = UIImage


    public typealias AppleEdgeInsets                        = UIEdgeInsets

#endif

#if os(iOS) || os(tvOS)

    import UIKit.UINib
    import UIKit.UIView

    import UIKit.UICollectionView
    import UIKit.UIViewController

    public typealias AppleNib                               = UINib
    public typealias AppleView                              = UIView
    public typealias AppleScreen                            = UIScreen


    public typealias AppleViewController                    = UIViewController


    public typealias AppleCollectionViewCell                = UICollectionViewCell
    public typealias AppleCollectionViewReusableView        = UICollectionReusableView
    public typealias AppleCollectionView                    = UICollectionView
    public typealias AppleCollectionViewLayout              = UICollectionViewLayout
    public typealias AppleCollectionViewLayoutAttributes    = UICollectionViewLayoutAttributes
    public typealias AppleCollectionViewFlowLayout          = UICollectionViewFlowLayout;
    public typealias AppleCollectionViewDataSource          = UICollectionViewDataSource
    public typealias AppleCollectionViewDelegate            = UICollectionViewDelegate
    public typealias AppleCollectionViewDelegateFlowLayout  = UICollectionViewDelegateFlowLayout;

    public let AppleCollectionElementKindSectionHeader      = UICollectionElementKindSectionHeader
    public let AppleCollectionElementKindSectionFooter      = UICollectionElementKindSectionFooter

    public extension AppleScreen {
        static var `default`: AppleScreen {
            return AppleScreen.main
        }
    }
    
#elseif os(macOS)

    import AppKit.NSNib
    import AppKit.NSColor
    import AppKit.NSCollectionView
    import AppKit.NSViewController
    import AppKit.NSView

    public typealias AppleViewController                    = NSViewController
    public typealias AppleNib                               = NSNib
    public typealias AppleColor                             = NSColor
    public typealias AppleImage                             = NSImage
    public typealias AppleCollectionViewCell                = NSCollectionViewItem
    public typealias AppleCollectionViewReusableView        = NSCollectionViewItem
    public typealias AppleCollectionView                    = NSCollectionView
    public typealias AppleCollectionViewLayout              = NSCollectionViewLayout
    public typealias AppleCollectionViewLayoutAttributes    = NSCollectionViewLayoutAttributes
    public typealias AppleCollectionViewFlowLayout          = NSCollectionViewFlowLayout
    public typealias AppleCollectionViewDataSource          = NSCollectionViewDataSource
    public typealias AppleCollectionViewDelegate            = NSCollectionViewDelegate
    public typealias AppleCollectionViewDelegateFlowLayout  = NSCollectionViewDelegateFlowLayout

    public let AppleCollectionElementKindSectionHeader      = NSCollectionView.SupplementaryElementKind.sectionHeader.rawValue
    public let AppleCollectionElementKindSectionFooter      = NSCollectionView.SupplementaryElementKind.sectionFooter.rawValue

    public typealias AppleView                              = NSView
    public typealias AppleEdgeInsets                        = NSEdgeInsets
    public typealias AppleScreen                            = NSScreen

    public extension AppleScreen {
        static var `default`: AppleScreen {
            return AppleScreen.main!
        }
        var bounds: CGRect { return NSRectToCGRect(self.visibleFrame) }
    }

    public extension AppleNib
    {

        convenience init?(nibName: String, bundle: Bundle?) {
            var bundleVar = Bundle.main
            if let bundle = bundle {
                bundleVar = bundle
            }
            if bundleVar.path(forResource: nibName, ofType: "nib") == nil {
                return nil
            }
            
            self.init(nibNamed: NSNib.Name(rawValue: nibName), bundle: bundle)
        }
    }

#endif
