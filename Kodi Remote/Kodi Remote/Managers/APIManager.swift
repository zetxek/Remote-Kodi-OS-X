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

class APIManager{

    
    func sendMessage(action : String){
        
        let parameters = [
            "jsonrpc": "2.0",
            "method": action,
            "id": 1
        ]
        
        let url : String = "http://192.168.192.8:8080/jsonrpc"
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
                    
                    println(error)
                    
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
        
    }

}