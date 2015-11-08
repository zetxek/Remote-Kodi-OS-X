//
//  APIManager.swift
//  Kodi Remote
//
//  Created by Adrián Moreno Peña on 26/03/15.
//  Copyright (c) 2015 Nyan Software. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol APIManagerDelegate{
    
    func didReceiveError(error: NSError!)
    func didMissUserSettings(error: NSString)
    
}

class APIManager{
    
    init(){
    
    }

    var delegate : APIManagerDelegate?
    
    func sendMessage(action : String){
        
        let parameters = [
            "jsonrpc": "2.0",
            "method": action,
            "id": 1
        ]
        
        
        
        let preferences = NSUserDefaults.standardUserDefaults()
        
        if let baseUrl: NSString = preferences.stringForKey(UserPreferences.preferenceUrl) {
        
            var url : String = ""
            if let port = preferences.integerForKey(UserPreferences.preferencePort) as Int!{
                url = "\(baseUrl):\(port)/jsonrpc"
            }else{
                url = "\(baseUrl)/jsonrpc"
            }
            
            var user : NSString = ""
            if (preferences.valueForKey(UserPreferences.preferenceUser) != nil){
                user = preferences.stringForKey(UserPreferences.preferenceUser) as NSString!
            }
            
            var password : NSString = ""
            if (preferences.valueForKey(UserPreferences.preferencePassword) != nil){
                password = preferences.stringForKey(UserPreferences.preferencePassword) as NSString!
            }

            let credential = NSURLCredential(user: user as String, password: password as String, persistence: .ForSession)

            log.debug("Invoking Kodi server, url=\(url)")

            
            let URL = NSURL(string: url)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL)
            mutableURLRequest.HTTPMethod = "POST"
            
            do{
                try
                    mutableURLRequest.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions())
            }catch{
                
            }
            
            mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request(mutableURLRequest)
                .authenticate(usingCredential: credential)
                .responseJSON { response in
                    
                    // Request error
                    if(response.result.error != nil) {
                    
                        self.delegate?.didReceiveError(response.result.error)
                        
                    }else{
                        
                        // No error
                        let json = JSON(response.data!)
                        print(json)
                        
                        
                    }
                    
                    
                    /*if let delegate = self.delegate {
                    var json = JSON(data!)
                    //delegate.didReceiveResult(json)
                    println(json)
                    }*/
            }
            
            
        } else {
            
            log.debug("Error retrieving user options")
            delegate?.didMissUserSettings("You must enter the server URL in the settings")
            
        }
        
        
        
        
    }

}