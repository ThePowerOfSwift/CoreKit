//
//  StringData.swift
//  Example
//
//  Created by Tibor Bödecs on 2017. 10. 02..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation
import CoreKit
import CoreGraphics


class StringData: CollectionViewData<StringItem, String> {
    
    override func initialize() {
        
        super.initialize()
        
//        self.config = { item, data, indexPath, grid in
//            item.textLabel.text = data
//        }
//        self.size = { _, _, _ -> CGSize in
//            return CGSize(width: 320, height: 64)
//        }
//        self.callback = { _, _ -> Bool in
//            print("tap")
//            return true
//        }
    }

    override func config(item: StringItem, data: String, indexPath: AppleIndexPath, grid: Grid) {
        #if os(iOS) || os(tvOS)
            item.textLabel.text = data
        #endif
        #if os(macOS)
            item.textLabel.stringValue = data
        #endif
        
    }
    
    override func size(data: String, indexPath: AppleIndexPath, grid: Grid) -> CGSize {
        return CGSize(width: 320, height: 128)
    }
    
    override func callback(data: String, indexPath: AppleIndexPath) -> Bool {
        print("tap from method")
        return true
    }

}
