//
//  CollectionViewItem.swift
//  SlidesMagic
//
//  Created by Gabriel Miro on 28/11/15.
//  Copyright © 2015 razeware. All rights reserved.
//

import Cocoa
import CoreKit


class CollectionViewItem: CollectionViewCell {
    
    
    //  var imageFile: ImageFile? {
    //    didSet {
    //      guard viewLoaded else { return }
    //      if let imageFile = imageFile {
    //        imageView?.image = imageFile.thumbnail
    //        textField?.stringValue = imageFile.fileName
    //      } else {
    //        imageView?.image = nil
    //        textField?.stringValue = ""
    //      }
    //    }
    //  }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
//        
        self.view.layer?.backgroundColor = NSColor.blue.cgColor
//
//        view.layer?.borderWidth = 0
//        view.layer?.borderColor = NSColor.red.cgColor
    }

//    func setHighlight(selected: Bool) {
//        view.layer?.borderWidth = selected ? 5.0 : 0.0
//    }
    
}
