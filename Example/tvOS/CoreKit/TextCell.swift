//
//  TextCell.swift
//  CVMC
//
//  Created by Tibor Bodecs on 2016. 03. 29..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//

import UIKit
import CoreKit


class TextCell : CollectionViewCell
{
	@IBOutlet weak var textLabel: UILabel!
    
    
    override func reset() {
        super.reset()

        self.textLabel.text = nil
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            if self.isFocused {
                self.textLabel.font = UIFont.systemFont(ofSize: 32)
            }
            else {
                self.textLabel.font = UIFont.systemFont(ofSize: 16)
            }
        }) {
            
        }
    }
    
}
