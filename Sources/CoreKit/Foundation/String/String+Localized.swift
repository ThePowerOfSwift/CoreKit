//
//  String+Localized.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation


public extension String {

    /**
     Returns an localized string based on the localization table
     
     - parameter param: The localization parameters if there is any
     - parameter table: The name of the localization table
     
     - returns: Localized string
     */
    public func localized(param: String = "", table: String? = nil) -> String {
        return Bundle.main.localizedString(forKey: self, value: param, table: table)
    }
}
