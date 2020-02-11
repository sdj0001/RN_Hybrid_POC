//
//  RNBridgeViewController.swift
//  RN_Hybrid_test
//
//  Created by shibowen on 2020/2/10.
//  Copyright © 2020 shibowen. All rights reserved.
//

import UIKit

class RNBridgeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(backAction), name: NSNotification.Name(rawValue: BACKNOTIFY), object: nil)
        setUpRN()
    }
    

    func setUpRN() {
//        let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")!
        let jsCodeLocation = GA_CURRENT_RN_BUNDLE.url(forResource: "main", withExtension: "jsbundle")!
        let mockData:NSDictionary = ["scores":
            [
                ["name":"Alex", "value":"42"],
                ["name":"Joel", "value":"10"]
            ]
        ]
        let rootView = RCTRootView(
            bundleURL: jsCodeLocation,
            moduleName: "RNHighScores",
            initialProperties: mockData as [NSObject : AnyObject],
            launchOptions: nil
        )
        self.view = rootView
    }
    
    @objc func backAction() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: BACKNOTIFY), object: nil)
    }

}
