//
//  SPNetwork.swift
//  
//
//  Created by shibowen on 2018/6/20.
//  Copyright © 2018年 shibowen. All rights reserved.
//

import Foundation
import Alamofire

class SPNetwork {

    class func download(urlString: String, to: URL, onSuccess:@escaping (_ destinationURL: URL)->Void, onError: @escaping (_ error: Error)->Void) {
        // Create folders if not existed, delete file if existed.
        let fileManager = FileManager()
        let destinationFolder = to.deletingLastPathComponent()
        do {
            try fileManager.createDirectory(at: destinationFolder, withIntermediateDirectories: true, attributes: nil)
            try fileManager.removeItem(at: to)
        } catch {
            print("\(error)")
        }
        
        let destination: DownloadRequest.DownloadFileDestination = {_, _ in
            return (to, [.createIntermediateDirectories, .removePreviousFile])
        }
        
        Alamofire.download(urlString, method: .get, to: destination)
            .validate()
            .response{response in
                if let error = response.error {
                    onError(error)
                } else {
                    onSuccess(to)
                }
        }
    }
}
