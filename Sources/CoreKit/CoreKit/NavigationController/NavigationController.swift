//
//  NavigationController.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)

    
#if os(iOS)
        import UIKit.UIApplication
        import UIKit.UIGestureRecognizer
#endif

    
    open class NavigationViewController: AppleNavigationController {
        
        public init() {

#if os(iOS)
            super.init(navigationBarClass: AppleNavigationBar.self, toolbarClass: AppleToolbar.self)
#endif
#if os(tvOS)
            super.init(navigationBarClass: AppleNavigationBar.self, toolbarClass: nil)
#endif
            
            self.initialize()
        }
        
        public override init(rootViewController: AppleViewController) {
#if os(iOS)
            super.init(navigationBarClass: AppleNavigationBar.self, toolbarClass: AppleToolbar.self)
#endif
#if os(tvOS)
            super.init(navigationBarClass: AppleNavigationBar.self, toolbarClass: nil)
#endif

            self.viewControllers = [rootViewController]
            
            self.initialize()
        }
        
        public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: AppleBundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            
            self.initialize()
        }
        
        public required init?(coder aDecoder: AppleCoder) {
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
    
#if os(iOS)
        extension NavigationViewController: UIGestureRecognizerDelegate {
            
            public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
                return true
            }
        }
#endif
    
#endif

