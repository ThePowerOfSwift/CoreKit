//
//  ViewController.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS)
    import UIKit.UIApplication
#endif


#if os(iOS) || os(tvOS) || os(macOS)
    
    
    open class ViewController: AppleViewController {
        
        public required init?(coder aDecoder: AppleCoder) {
            super.init(coder: aDecoder)
            
            self.initialize()
        }
        
        public init() {
            super.init(nibName: nil, bundle: nil)
            
            self.initialize()
        }
        
        #if os(iOS) || os(tvOS)
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: AppleBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.initialize()
        }
        #endif
        #if os(macOS)
        override init(nibName nibNameOrNil: AppleNib.Name?, bundle nibBundleOrNil: AppleBundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            
            self.initialize()
        }
        #endif
        
        open func initialize() {
            
        }
        #if os(iOS) || os(tvOS)
        open override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()

            if self.isViewLoaded && self.view.window == nil {
        
            }
        }
        #endif
        deinit {
            
        }
        
        #if os(iOS) || os(tvOS)
        open func back() {
        _ = self.navigationController?.popViewController(animated: true)
        }
        
        open func close() {
        self.dismiss(animated: true, completion: nil)
        }
        #endif
        
        #if os(iOS)
        open override var shouldAutorotate: Bool {
        return false
        }
        
        open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
        }
        
        open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
        }
        
        open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        }
        #endif
    }
    
#endif
