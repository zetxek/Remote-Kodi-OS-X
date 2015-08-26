//
//  TransparentButton.swift
//  Kodi Remote
//
//  Created by Adrián Moreno Peña on 27/08/15.
//  Copyright (c) 2015 Nyan Software. All rights reserved.
//

import Foundation
import Cocoa

class TransparentButton : NSButton{

    override func drawRect(dirtyRect: NSRect) {
        self.bordered = false
        NSRectFill(dirtyRect)
        super.drawRect(dirtyRect)
    }
    
    override func highlight(flag: Bool) {
        self.bordered = false
        //NSRectFill(dirtyRect)
        //super.drawRect(dirtyRect)
    }
}
