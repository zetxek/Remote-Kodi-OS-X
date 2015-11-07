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
import ReactiveCocoa

class APIManager{
    
    init(){
        requestManager = Manager()
    }
    
    func requestWorkspaces() -> SignalProducer<NSDictionary, NSError> {
        return SignalProducer { observer, _ in
            self.requestManager
                .request(
                    .GET,
                    "https://app.asana.com/api/1.0/workspaces")
                .validate()
                .responseJSON {_, _, JSON, error in
                    if let error = error {
                        sendError(observer, error)
                    } else {
                        if let dict = JSON as? NSDictionary {
                            sendNext(observer, dict)
                        }
                        sendCompleted(observer)
                    }
            }
            return
        }
    }
    
    // MARK: private
    private let requestManager: Alamofire.Manager

    

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
            
            var JSONSerializationError: NSError? = nil
            do {
                mutableURLRequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: [])
            } catch var error as NSError {
                JSONSerializationError = error
                mutableURLRequest.HTTPBody = nil
            }
            mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request(mutableURLRequest)
                .authenticate(usingCredential: credential)
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
            
            log.debug("Error retrieving user options")
            delegate?.didMissUserSettings("You must enter the server URL in the settings")
            
        }
        
        
        
        
    }

}


protocol APIManagerDelegate{
    
    func didReceiveError(error: NSError!)
    func didMissUserSettings(error: NSString)
    
}