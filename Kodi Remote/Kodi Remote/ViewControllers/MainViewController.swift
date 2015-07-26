//
//  ViewController.swift
//  Kodi Remote
//
//  Created by Adrián Moreno Peña on 23/03/15.
//  Copyright (c) 2015 Nyan Software. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON
import ReactiveCocoa

class MainViewController: NSViewController {
    
    @IBOutlet var btnOk: NSButton!
    @IBOutlet var btnUp: NSButton!
    @IBOutlet var btnDown: NSButton!
    @IBOutlet var btnRight: NSButton!
    @IBOutlet var btnLeft: NSButton!
    @IBOutlet var btnBack: NSButton!
    @IBOutlet var btnContext: NSButton!
    
    let apiManager : APIManager = APIManager()
    var btnActions : [NSButton: String] = [NSButton: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btnActions = [
            btnOk:      "Input.Select",
            btnUp:      "Input.Up",
            btnDown:    "Input.Down",
            btnRight:   "Input.Right",
            btnLeft:    "Input.Left",
            btnBack:    "Input.Back",
            btnContext: "Input.ContextMenu"
        ]
        
        
        let signalFromview = MutableProperty<String>("")
        
        //signalFromView.observe(next: { println($0) })

    }


    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func btnClick(sender: AnyObject) {
        
        if let action : NSString = btnActions[sender as! NSButton]{
            apiManager.sendMessage(action as String)
        }
        
    }
    
    
    
    override func keyDown(theEvent: NSEvent) {
        
        log.debug("ViewController. KeyPress detected: \(theEvent)")
        
        if (theEvent.keyCode == 1){
            //do whatever when the s key is pressed
        }
        
    }
   
    
    
    
}

