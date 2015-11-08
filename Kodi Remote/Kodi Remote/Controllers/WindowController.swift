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
            49:     "Input.ContextMenu", //space
            123:    "Input.Left", //left arrow
            126:    "Input.Up", // up arrow
            125:    "Input.Down", //down arrow
            124:    "Input.Right", //right arrow
            51:     "Input.Back", //backspace
            53:     "Input.Back",   //escape
            1010:   "Input.Select", //
            36:     "Input.Select", //enter
            
        ]
    }

    
    
    let apiManager : APIManager = APIManager()
    
    override func windowDidLoad() {

        self.window?.title = NSLocalizedString("AppTitle", comment: "")
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