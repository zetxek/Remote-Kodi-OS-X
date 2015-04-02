//
//  ResponderView.swift
//  Kodi Remote
//
//  Created by Adrián Moreno Peña on 26/03/15.
//  Copyright (c) 2015 Nyan Software. All rights reserved.
//

import Foundation
import Cocoa

class ResponderView : NSView {
    
    let apiManager : APIManager = APIManager()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func keyDown(theEvent: NSEvent) {
        NSLog("KeyDown: %@", theEvent)
        
        if let action : NSString = WindowController.Static.keyActions[theEvent.keyCode]{
            apiManager.sendMessage(action)
        }

    }
}
