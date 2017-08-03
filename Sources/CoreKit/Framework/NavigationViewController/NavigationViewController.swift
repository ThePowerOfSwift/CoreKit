//
//  NavigationViewController.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 04/09/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//

#if os(iOS)

import UIKit.UINavigationController
import UIKit.UINavigationBar


open class NavigationViewController: UINavigationController, UIGestureRecognizerDelegate {

    public init() {
        super.init(navigationBarClass: UINavigationBar.self, toolbarClass: nil)

        self.initialize()
    }

    public override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: UINavigationBar.self, toolbarClass: nil)

        self.viewControllers = [rootViewController]

        self.initialize()
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }

    open func initialize() {

    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        #if os(iOS)
            self.interactivePopGestureRecognizer?.delegate = self
        #endif
        //		if let navbar = self.navigationBar as? NavigationBar {
        //			navbar.imageViewTouched = {
        //				self.popToRootViewControllerAnimated(true)
        //			}
        //		}

    }

    public func pushViewController(viewController: UIViewController, animated: Bool, completion: @escaping VoidBlock) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }


    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    #if os(iOS)
    override open var shouldAutorotate: Bool {
        if let shouldRotate = self.topViewController?.shouldAutorotate {
            return shouldRotate
        }
        return super.shouldAutorotate
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let orientation = self.topViewController?.supportedInterfaceOrientations {
            return orientation
        }
        return super.supportedInterfaceOrientations
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if let orientation = self.topViewController?.preferredInterfaceOrientationForPresentation {
            return orientation
        }
        return super.preferredInterfaceOrientationForPresentation
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        if let style = self.topViewController?.preferredStatusBarStyle {
            return style
        }
        return super.preferredStatusBarStyle
    }
    #endif

}

#endif
