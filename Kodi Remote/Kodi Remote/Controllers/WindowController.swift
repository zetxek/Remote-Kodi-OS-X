//
//  WindowController.swift
//  Kodi Remote
//
//  Created by Adrián Moreno Peña on 26/03/15.
//  Copyright (c) 2015 Nyan Software. All rights reserved.
//

import Foundation
import Cocoa

class WindowController : NSWindowController {
    
    struct Static {
        static let keyActions : [UInt16: String] = [
            49:     "Input.ContextMenu",
            123:    "Input.Left",
            126:    "Input.Up",
            125:    "Input.Down",
            124:    "Input.Right",
            51:     "Input.Back",
            1010:   "Input.Select"
        ]
    }

    
    
    let apiManager : APIManager = APIManager()
    
    override func windowDidLoad() {

        self.window?.title = "Kodi Remote"
		self.window?.titlebarAppearsTransparent = true
		self.window?.movableByWindowBackground  = true
		self.window?.backgroundColor = NSColor.blackColor()
    }
    
    
    override func keyDown(theEvent: NSEvent) {
        if let action = Static.keyActions[theEvent.keyCode]{
            apiManager.sendMessage(action)
        }
        
    }
    
    
    
}