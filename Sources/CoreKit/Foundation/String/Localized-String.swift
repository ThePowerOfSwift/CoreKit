//
//  Localized-String.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 04/09/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
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
