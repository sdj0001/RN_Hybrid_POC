//
//  SPDataManager+Delegate.swift
//  
//
//  Created by shibowen on 2018/6/20.
//  Copyright © 2018年 shibowen. All rights reserved.
//

import UIKit
import Alamofire

protocol SPDataManagerDelegate {
    func dataManager(_ dataManager: SPDataManager!, onSuccess json: Any!)
    func dataManager(_ dataManager: SPDataManager!, onFailure error: Error!)
}

class SPDataManager {
    
    var delegate: SPDataManagerDelegate?
    
    static let `default` = SPDataManager()

    func download(urlString: String, to: URL, onSuccess:@escaping (_ destinationURL: URL)->Void, onError: @escaping (_ error: Error)->Void) {
        var targetPath = ""
        let result = to.absoluteString.components(separatedBy: "file:///")
        if result.count > 1 {
            targetPath = result[1]
        } else if result.count == 1 {
            targetPath = result[0]
        }
        if FileManager.default.fileExists(atPath: targetPath) {
            onSuccess(to)
        } else {
            SPNetwork.download(urlString: urlString,
                               to: to,
                               onSuccess: { destinationURL in
                                onSuccess(destinationURL)},
                               onError: { error in
                                onError(SPError(error))
            })
        }
        
    }
    
    func download(urlString: String, onSuccess:@escaping (_ data: Data)->Void, onError: @escaping (_ error: Error)->Void) {
        Alamofire.request(urlString).responseData { (response) in
            guard let data = response.result.value else {
                if response.error != nil {
                    onError(response.error!)
                }
                return
            }
            onSuccess(data)
        }
    }
    
}

class SPError: Error, CustomStringConvertible {
    var spEcode: String?
    var spEmessage: String?
    var description: String {
        set {
            spEmessage = newValue
        }
        get {
            let errmsg = spEmessage ?? "No content"
            return "SPErrorMessage: \"" + errmsg + "\""
        }
    }
    
    convenience init(_ e: Error) {
        self.init()
        self.description = e.localizedDescription
    }
    
    convenience init(_ string: String) {
        self.init()
        self.description = string
    }
}

