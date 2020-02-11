//
//  ViewController.swift
//  RN_Hybrid_test
//
//  Created by shibowen on 2020/2/7.
//  Copyright © 2020 shibowen. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapAction(_ sender: UIButton) {
        NSLog("Hello")

        let vc = RNBridgeViewController()
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true, completion: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

