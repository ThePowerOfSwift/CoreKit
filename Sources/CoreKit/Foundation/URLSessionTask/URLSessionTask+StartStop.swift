//
//  URLSessionTask+StartStop.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSURLSession


extension URLSessionTask {

    /**
     Simple alias for the resume function
     */
    func start() {
        self.resume()
    }

    /**
     Simple alias for the cancel function
     */
    func stop() {
        self.cancel()
    }
}
