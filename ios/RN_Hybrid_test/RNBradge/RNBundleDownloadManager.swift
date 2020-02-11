//
//  RNBundleDownloadManager.swift
//  RN_Hybrid_test
//
//  Created by shibowen on 2020/2/11.
//  Copyright © 2020 shibowen. All rights reserved.
//

import UIKit

let GA_LOCAL_BUNDL_EXIST: String =  "GA_LOCAL_BUNDL_EXIST"
let GA_LOCAL_BUNDLE_NAME = "GALocalBundle"
var GA_CURRENT_RN_BUNDLE: Bundle {
    get {
        return (UserDefaults.standard.bool(forKey: GA_LOCAL_BUNDL_EXIST) == true ? RNBundleDownloadManager.shared.SPLocalizeLocalBundle() : Bundle.main)
    }
}

class RNBundleDownloadManager {
    
    static let shared = RNBundleDownloadManager()
    private var localBundle: Bundle? = nil

    func getBundle() {
        SPDataManager.default.download(urlString: "http://pic.buyddy.qingke.me/main.jsbundle", onSuccess: { (data) in
            if !self.save(data: data, to: "\(GA_LOCAL_BUNDLE_NAME)", with: "main.jsbundle") {
                print("jsbundle save error")
            }
            UserDefaults.standard.set(true, forKey: GA_LOCAL_BUNDL_EXIST)
            print("jsbundle download success !!!")
        }) { (error) in
            print(error)
        }
    }
    
    func SPLocalizeLocalBundle() -> Bundle {
        guard localBundle != nil else {
            createBundle()
            return localBundle ?? Bundle.main
        }
        return localBundle!
    }
    
    private func createBundle() {
        guard let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return
        }
        let dataPath = (documentsDirectory as NSString).appendingPathComponent(GA_LOCAL_BUNDLE_NAME)
        localBundle = Bundle.init(path: dataPath)
    }
    
    private func save(data: Data, to folder: String, with fileName: String) -> Bool {
        guard let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return false
        }
        let dataPath = (documentsDirectory as NSString).appendingPathComponent(folder)
        if !FileManager.default.fileExists(atPath: dataPath) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
                return false
            }
        }
        let filePath = "\(dataPath)/\(fileName)"
        if !(data as NSData).write(toFile: filePath, atomically: true) {
            print("error to create File :\(filePath)")
            return false
        } else {
            let url = URL.init(fileURLWithPath: filePath)
            addSkipBackupAttributeToItem(at: url)
            print("DOWNLOADED AND SAVED: \(fileName) to \(filePath)")
        }
        return true
    }
    
    private func addSkipBackupAttributeToItem(at url: URL) {
        assert(FileManager.default.fileExists(atPath: url.path))
        do {
            try (url as NSURL).setResourceValue(NSNumber.init(booleanLiteral: true), forKey: .isExcludedFromBackupKey)
        } catch {
            print("Error excluding \(url.lastPathComponent) from backup \(error)")
        }
    }
    
}
