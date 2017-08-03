//
//  TextCell.swift
//  CVMC
//
//  Created by Tibor Bodecs on 2016. 03. 29..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//

import class UIKit.UILabel
import CoreKit


class TextCell : CollectionViewCell
{
	@IBOutlet weak var textLabel: UILabel!
    
    
    override func reset() {
        super.reset()

        self.textLabel.text = nil
    }

}
