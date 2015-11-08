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
        Fabric.with([Crashlytics.self])
    }

    func applicationWillTerminate(aNotification: NSNotification) {

    }

}

