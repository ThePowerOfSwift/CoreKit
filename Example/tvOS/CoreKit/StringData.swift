//
//  StringData.swift
//  CVMC
//
//  Created by Tibor Bodecs on 2016. 03. 29..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//

import UIKit
import CoreKit


class StringData: CollectionViewData<TextCell, String> {

    override func initialize() {
        super.initialize()
        
        self.item = "hehehe"
        self.config = { cell, item, indexPath, grid in
            cell.textLabel.text = item
        }

        self.size = { item, indexPath, grid in
            return grid.size(height: 44)
        }
    }
}

