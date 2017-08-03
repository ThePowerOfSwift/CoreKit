//
//  TabBarViewController.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 04/09/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit.UITabBarController


open class TabBarViewController: UITabBarController, UITabBarControllerDelegate {


    open override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }


    #if os(iOS)
    open override var shouldAutorotate: Bool {
        if let viewController = self.viewControllers?[self.selectedIndex] {
            return viewController.shouldAutorotate
        }
        return super.shouldAutorotate
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let viewController = self.viewControllers?[self.selectedIndex] {
            return viewController.supportedInterfaceOrientations
        }
        return super.supportedInterfaceOrientations
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if let viewController = self.viewControllers?[self.selectedIndex] {
            return viewController.preferredInterfaceOrientationForPresentation
        }
        return super.preferredInterfaceOrientationForPresentation
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let viewController = self.viewControllers?[self.selectedIndex] {
            return viewController.preferredStatusBarStyle
        }
        return super.preferredStatusBarStyle
    }
    #endif

}
#endif
