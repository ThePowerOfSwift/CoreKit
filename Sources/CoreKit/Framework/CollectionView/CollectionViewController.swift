//
//  CollectionViewController.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2016. 01. 13..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)
import CoreGraphics
#if os(iOS)
import UIKit.UITraitCollection
#endif


open class CollectionViewController: AppleViewController
{
    @IBOutlet open weak var collectionView: CollectionView!

    open override func loadView() {
        super.loadView()

#if os(iOS)
        let collectionView  = CollectionView(layout: CollectionViewFlowLayout())
        self.collectionView = collectionView
        self.view.addSubview(self.collectionView)

        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
#endif
    }
    
    #if os(iOS)
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        if self.isViewLoaded && self.view.window == nil {
            self.collectionView = nil
        }
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard
            let previousTraitCollection = previousTraitCollection ,
            self.traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass ||
            self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass
        else {
            return
        }

        for section in self.collectionView.source?.sections ?? [] {
            section.grid?.traitCollection = self.traitCollection
        }
        self.collectionView.source?.grid.traitCollection = self.traitCollection
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.reloadData()

    }

    open override func viewWillTransition(to size: CGSize,
                                 with coordinator: UIViewControllerTransitionCoordinator) {

        super.viewWillTransition(to: size, with: coordinator)

        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.bounds.size = size

        coordinator.animate(alongsideTransition: { [weak self] context in
            for section in self?.collectionView.source?.sections ?? [] {
                section.grid?.traitCollection = self?.traitCollection
            }
            self?.collectionView.source?.grid.traitCollection = self?.traitCollection

            context.viewController(forKey: UITransitionContextViewControllerKey.from)

            }, completion: { [weak self] context in
                self?.collectionView.collectionViewLayout.invalidateLayout()
            })
    }
    #endif
}


public extension CollectionViewController
{
    public func grid(_ columns: CGFloat = 1,
                     margin: CGFloat = 0,
                     padding: CGFloat = 0,
                     insets: AppleEdgeInsets? = nil,
                     lineSpacing: CGFloat? = nil,
                     itemSpacing: CGFloat?) -> Grid {

        #if os(iOS)
            let grid         = Grid(view: self.collectionView, traitCollection: self.traitCollection)
        #else
            let grid         = Grid(view: self.collectionView)
        #endif
        grid.columns     = columns
        grid.margin      = margin
        grid.padding     = padding
        grid.insets      = insets
        grid.lineSpacing = lineSpacing
        grid.itemSpacing = itemSpacing
        return grid
    }
}

#endif
