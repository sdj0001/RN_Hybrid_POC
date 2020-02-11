//
//  RNBridgeManager.swift
//  RN_Hybrid_test
//
//  Created by shibowen on 2020/2/10.
//  Copyright © 2020 shibowen. All rights reserved.
//

import UIKit

let BACKNOTIFY = "BACKNOTIFY"

@objc(RNBradgeManager)
class RNBridgeManager: NSObject {
    
    @objc(backAction)
    func backAction() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: BACKNOTIFY), object: nil)
    }
    
    
    
}

