//
//  AppleViewController+Alert.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
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
            
            alertController.action(title: "Ok".localized()) { (action) in okClosure?() }
            
            if cancelClosure != nil {
                alertController.action(title: "Cancel".localized()) { (action) in cancelClosure?() }
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
