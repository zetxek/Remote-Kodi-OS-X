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
    
    // MARK: General events
    override func viewDidLoad() {
        
        let preferences = NSUserDefaults.standardUserDefaults()
        
        if let url: NSString = preferences.stringForKey(UserPreferences.preferenceUrl) {
            txtUrl.stringValue = url as String
        }

        if let port = preferences.integerForKey(UserPreferences.preferencePort) as Int! {
            txtPort.stringValue = String(port)
        }
        
        if let user: NSString = preferences.stringForKey(UserPreferences.preferenceUser) {
            txtUser.stringValue = user as String
        }
        
        if let password: NSString = preferences.stringForKey(UserPreferences.preferencePassword) {
            txtPassword.stringValue = password as String
        }
    }
    
    
    // MARK: GUI actions
    
    @IBAction func saveAction(sender: AnyObject!) {
        
        log.debug("Saving settings")
        
        let formValidationResult = self.isValidForm()
        
        if ( formValidationResult.formIsOK ){
            
            let preferences = NSUserDefaults.standardUserDefaults()
            
            
            preferences.setValue    (txtUrl.stringValue,     forKey: UserPreferences.preferenceUrl)
            preferences.setInteger  (txtPort.integerValue,   forKey: UserPreferences.preferencePort)
            preferences.setValue    (txtUser.stringValue,    forKey: UserPreferences.preferenceUser)
            preferences.setValue    (txtPassword.stringValue,forKey: UserPreferences.preferencePassword)

            //  Save to disk
            let didSave = preferences.synchronize()
            
            if !didSave {
                //  Couldn't save (I've never seen this happen in real world testing)
                return
            }
            
            
            log.debug("Settings saved!")
            self.dismissController(sender)
            
        }else{
            
            let alertMessage:NSAlert = NSAlert()
            alertMessage.messageText = "Ooops!"
            alertMessage.informativeText = formValidationResult.errorMessage as String
            alertMessage.runModal()
            
        }
        
    }
    
    @IBAction func cancelAction(sender: AnyObject!) {
        log.debug("Cancelling settings")
        self.dismissController(sender)
    }

    
}


// MARK: screen logic

extension SettingsViewController{
    
    func isValidForm() ->  (formIsOK: Bool, errorMessage: NSString){
    
        if (!isValidUrl(txtUrl.stringValue)){
            log.debug("Invalid URL")
             return (false, "You must enter a valid URL, starting with http")
        }

        if (!txtPort.stringValue.isEmpty && !isValidNumber(txtPort.stringValue)){
            log.debug("Invalid port")
            return (false, "You must enter a valid port number")
        }
        
        
        return (true, "")
        
    }
    
    func isValidUrl(url : NSString) -> Bool{

        if let _ = NSURL(string: url as String) {
            return true
        } else {
            return false
        }

    }
    
    func isValidNumber(number : NSString) -> Bool{
        
        return true
        
    }
    


}
