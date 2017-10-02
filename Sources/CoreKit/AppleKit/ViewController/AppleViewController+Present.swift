//
//  AppleViewController+Present.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)

    public extension AppleViewController {
        
        public func present(viewController: AppleViewController, animated: Bool = true, completion: VoidBlock? = nil) {
            self.providesPresentationContextTransitionStyle = true
            self.definesPresentationContext = true
            viewController.modalPresentationStyle = .overCurrentContext
            self.present(viewController, animated: animated, completion:completion)
        }
    }

#endif
