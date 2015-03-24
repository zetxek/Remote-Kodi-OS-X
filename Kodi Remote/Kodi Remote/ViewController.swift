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

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func btnClick(sender: AnyObject) {


        // {"jsonrpc":"2.0","method":"Input.Left","id":1}
        let parameters = [
                "jsonrpc": "2.0",
                "method": "Input.Down",
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

