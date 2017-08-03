//
//  AppDelegate.swift
//  iOS
//
//  Created by Tibor Bodecs on 2016. 10. 18..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//

import UIKit
import CoreKit


@UIApplicationMain
class AppDelegate: UIResponder {

    var window: UIWindow?
}


extension AppDelegate: UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        Console.default.logLevel = .error

        return true
    }

}
