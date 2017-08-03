//
//  CollectionViewItem.swift
//  SlidesMagic
//
//  Created by Gabriel Miro on 28/11/15.
//  Copyright © 2015 razeware. All rights reserved.
//

import Cocoa
import CoreKit


class Section: CollectionViewCell {
    
//    var customView: SectionView! { return self.view as! SectionView }

    @IBOutlet weak var myField: NSTextField!

    
    override func loadView() {
        super.loadView()
        
//        print("load view")
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
//        print(self.view)
//        print(self.myField)
//        print("AWAKE FROM NIB!!!!!!!!!!!!")

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        print("VIEW DID LOAD!!!!!!!!!!!!")
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
//        print(self)
//        print("self.view \(self.view.frame)")

//        self.updateViewConstraints()
    }
    
}


