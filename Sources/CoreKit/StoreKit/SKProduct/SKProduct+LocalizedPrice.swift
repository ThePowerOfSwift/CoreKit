//
//  SKProduct+LocalizedPrice.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


#if os(iOS) || os(tvOS) || os(OSX)
import StoreKit


public extension SKProduct {
    
    public var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale

        if let price = formatter.string(from: self.price) {
            return price
        }
        return "n/a"
    }
}

#endif
