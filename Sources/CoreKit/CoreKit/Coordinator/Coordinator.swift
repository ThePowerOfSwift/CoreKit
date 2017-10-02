//
//  Coordinator.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)
    
    open class Coordinator {
        
        open var rootViewController: AppleViewController
        
        open var subCoordinators: [Coordinator] = []
        
        public init(rootViewController: AppleViewController) {
            self.rootViewController = rootViewController
        }
        
        open func addSubCoordinator(_ coordinator: Coordinator) {
            self.subCoordinators.append(coordinator)
        }
        
        open func removeSubCoordinator(_ coordinator: Coordinator) {
            self.subCoordinators = self.subCoordinators.filter { $0 !== coordinator }
        }
    }

#endif

