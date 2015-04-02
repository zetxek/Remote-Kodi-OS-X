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
            
            NSLog("Invoking Kodi server, url=\(url)")

            
            let URL = NSURL(string: url)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL)
            mutableURLRequest.HTTPMethod = "POST"
            
            var JSONSerializationError: NSError? = nil
            mutableURLRequest.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: nil, error: &JSONSerializationError)
            mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request(mutableURLRequest)
                .responseJSON
                { (request, response, data, error) in
                    
                    // Request error
                    if(error != nil) {
                        
                        self.delegate?.didReceiveError(error)
                        
                    }else{
                        
                        // No error
                        var json = JSON(data!)
                        println(json)
                        
                        
                    }
                    
                    
                    /*if let delegate = self.delegate {
                    var json = JSON(data!)
                    //delegate.didReceiveResult(json)
                    println(json)
                    }*/
            }
            
            
        } else {
            
            NSLog("Error retrieving user options")
            delegate?.didMissUserSettings("You must enter the server URL in the settings")
            
        }
        
        
        
        
    }

}