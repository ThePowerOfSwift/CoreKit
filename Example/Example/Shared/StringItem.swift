//
//  StringItem.swift
//  Example
//
//  Created by Tibor Bödecs on 2017. 10. 02..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreKit
#if os(iOS) || os(tvOS)
    import UIKit.UILabel
#endif
#if os(macOS)
    import AppKit.NSTextField
#endif


class StringItem: CollectionViewItem {

    #if os(iOS) || os(tvOS)
    @IBOutlet weak var textLabel: UILabel!
    #endif
    #if os(macOS)
    @IBOutlet weak var textLabel: NSTextField!
    #endif
   
 
    
    override func reset() {
        super.reset()
    
        #if os(iOS) || os(tvOS)
            self.textLabel.text = nil
        #endif
        #if os(macOS)
            self.textLabel.stringValue = ""
        #endif
    }
}
