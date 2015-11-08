//
//  AppDelegate.swift
//  Kodi Remote
//
//  Created by Adrián Moreno Peña on 23/03/15.
//  Copyright (c) 2015 Nyan Software. All rights reserved.
//

import Cocoa
import XCGLogger
import Fabric
import Crashlytics
import Parse

let log = XCGLogger.defaultInstance()

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        log.setup(.Debug, showLogLevel: true, showFileNames: true, showLineNumbers: true)
        
        // SDKs
        Fabric.with([Crashlytics.self])
        
        if let path = NSBundle.mainBundle().pathForResource("APIKeys", ofType: "plist") {
            
            if let keys = NSDictionary(contentsOfFile: path) {
                let applicationId = keys["parseApplicationId"] as? String
                let clientKey = keys["parseClientKey"] as? String
                
                // Initialize Parse.
                Parse.setApplicationId(applicationId!, clientKey: clientKey!)
                PFAnalytics.trackAppOpenedWithLaunchOptions(nil)
                
            }
            
        }
        
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        
    }
    
}

