//
//  Locale+Countries.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSLocale


public extension Locale {
    
    /**
     Returns all the countries with the country codes
     
     - returns: Array of country tuples
     */
    public static var countries: [(code: String, name: String)] {
        var locales = [(code: String, name: String)]()

        for regionCode in Locale.isoRegionCodes {
            let name = Locale.current.localizedString(forRegionCode: regionCode)!
            let code = regionCode
            let locale = (code: code, name: name)
            locales.append(locale)
        }
        return locales
    }
}
