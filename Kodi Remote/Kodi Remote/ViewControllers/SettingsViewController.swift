//
//  SettingsViewController.swift
//  Kodi Remote
//
//  Created by Adrián Moreno Peña on 01/04/15.
//  Copyright (c) 2015 Nyan Software. All rights reserved.
//

import Cocoa

class SettingsViewController : NSViewController {

    // MARK: Variable declaration and Outlets
    
    @IBOutlet var txtUrl: NSTextField!
    @IBOutlet var txtUser: NSTextField!
    @IBOutlet var txtPassword: NSTextField!
    @IBOutlet var txtPort: NSTextField!
    
    // MARK: GUI actions
    
    @IBAction func saveAction(sender: AnyObject!) {
        NSLog("Saving settings")
        
        let formValidationResult = self.isValidForm()
        
        if ( !formValidationResult.thereAreErrors ){
            
            self.dismissController(sender)
            
        }else{
            
            let alertMessage:NSAlert = NSAlert()
            alertMessage.messageText = "Ooops!"
            alertMessage.informativeText = formValidationResult.errorMessage
            alertMessage.runModal()
            
        }
        
    }
    
    @IBAction func cancelAction(sender: AnyObject!) {
        NSLog("Cancelling settings")
        self.dismissController(sender)
    }

    
}


// MARK: screen logic

extension SettingsViewController{
    
    func isValidForm() ->  (thereAreErrors: Bool, errorMessage: NSString){
    
        if (!isValidUrl(txtUrl.stringValue)){
             return (false, "You must enter a valid URL, starting with http")
        }

        //if (!isValidNumber(txtPort.stringValue)){
        //    return (false, "You must enter a valid URL, starting with http")
        //}
        
        return (true, "")
        
    }
    
    func isValidUrl(url : NSString) -> Bool{
        if var url = NSURL(string: url) {
            return true
        } else {
            return false
        }
    }


}
