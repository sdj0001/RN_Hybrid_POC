//
//  AppDelegate.swift
//  RN_Hybrid_test
//
//  Created by shibowen on 2020/2/7.
//  Copyright © 2020 shibowen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        RNBundleDownloadManager.shared.getBundle()
        return true
    }


}

