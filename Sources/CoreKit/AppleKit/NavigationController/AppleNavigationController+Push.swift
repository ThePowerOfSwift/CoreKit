//
//  AppleNavigationController+Push.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


#if os(iOS) || os(tvOS)
    
    import QuartzCore.CAAnimation

    public extension AppleNavigationController {

        public func pushViewController(viewController: AppleViewController, animated: Bool, completion: @escaping VoidBlock) {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            self.pushViewController(viewController, animated: animated)
            CATransaction.commit()
        }
    }

#endif
