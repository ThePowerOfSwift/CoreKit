//
//  Alert-UIViewController.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 04/09/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//


#if os(iOS)

import UIKit.UIViewController


public extension UIViewController {

    public func showAlert(title: String,
                        message: String,
                      okClosure: VoidBlock? = nil,
                  cancelClosure: VoidBlock? = nil,
                     completion: VoidBlock? = nil)
    {
        let alertController = UIAlertController(title: title.localized(),
                                              message: message.localized(),
                                       preferredStyle: .alert)

        alertController.action(title: "Ok") { (action) in okClosure?() }

        if cancelClosure != nil {
            alertController.action(title: "Cancel") { (action) in cancelClosure?() }
        }

        OperationQueue.main.addOperation {
            self.present(alertController, animated: true) {
                completion?()
            }
        }
    }
}



public extension UIAlertController {

    @discardableResult
    public func action(title: String,
                       style: UIAlertActionStyle = .default,
                  completion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController
    {
        let action = UIAlertAction(title: title, style: style, handler: completion)
        self.addAction(action)
        return self
    }
}


#endif
