//
//  ViewController.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 04/09/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit.UIApplication
#endif


#if os(iOS) || os(tvOS) || os(macOS)

open class ViewController: AppleViewController {

    #if os(iOS) || os(tvOS)
    public init() {
        super.init(nibName: nil, bundle: nil)

        self.initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.initialize()
    }
    #endif

    open func initialize() {

    }

    deinit {
//        dlog("deinit: \(self)")
    }

    #if os(iOS) || os(tvOS)
    func back() {
        _ = self.navigationController?.popViewController(animated: true)
    }

    func close() {
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
