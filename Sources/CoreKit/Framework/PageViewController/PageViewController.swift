//
//  PageViewController.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 04/09/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit.UIPageViewController


open class PageViewController: UIPageViewController {

    private var scrollViewCache: UIScrollView!

    public lazy var scrollView: UIScrollView = {
        if self.scrollViewCache == nil {
            self.scrollViewCache = self.view.subviews.flatMap { $0 as? UIScrollView }.first
        }
        return self.scrollViewCache
    }()

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.initialize()
    }

    public override init(transitionStyle style: UIPageViewControllerTransitionStyle,
                         navigationOrientation: UIPageViewControllerNavigationOrientation,
                         options: [String : Any]? = nil)
    {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)

        self.initialize()
    }

    open func initialize() {

    }

    public convenience init(orientation: UIPageViewControllerNavigationOrientation = .horizontal,
                            margin: CGFloat = 0.0)
    {
		let options = [UIPageViewControllerOptionInterPageSpacingKey : margin]

        self.init(transitionStyle: .scroll, navigationOrientation: orientation, options: options)
	}
}

#endif
