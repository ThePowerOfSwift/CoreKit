//
//  AppleViewController+Hierarchy.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
    public extension AppleViewController {
        /**
         Adds a view controller as a child
         
         - parameter viewController: The view controller
         - parameter toView:         The view to add the view controller's view (default: self.view)
         */
        public func addChild(viewController: AppleViewController, toView: AppleView? = nil) {
            let view: AppleView = toView ?? self.view
            self.addChildViewController(viewController)
            viewController.willMove(toParentViewController: self)
            view.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
        }
        
        /**
         Removes a view controller from the hierarchy
         */
        public func removeFromParent() {
            self.willMove(toParentViewController: nil)
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        }
        
}
    
#endif
