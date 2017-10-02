//
//  PageViewController.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
    import UIKit.UIPageViewController
    
    open class PageViewController: ApplePageViewController {
        
        private var scrollViewCache: AppleScrollView!
        
        public lazy var scrollView: AppleScrollView = {
            if self.scrollViewCache == nil {
                self.scrollViewCache = self.view.subviews.flatMap { $0 as? AppleScrollView }.first
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
        
        public convenience init(orientation: UIPageViewControllerNavigationOrientation = .horizontal,
                                margin: CGFloat = 0.0)
        {
            let options = [UIPageViewControllerOptionInterPageSpacingKey : margin]
            
            self.init(transitionStyle: .scroll, navigationOrientation: orientation, options: options)
        }

        open func initialize() {
            
        }

    }
    
#endif

