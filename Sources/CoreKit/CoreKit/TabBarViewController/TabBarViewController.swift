//
//  TabBarViewController.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
#if os(iOS)
    import UIKit.UIApplication
#endif
    
    open class TabBarViewController: AppleTabBarController {

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

