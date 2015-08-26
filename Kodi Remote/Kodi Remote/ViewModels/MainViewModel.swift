//
//  MainViewModel.swift
//  Kodi Remote
//
//  Created by Adrián Moreno Peña on 27/07/15.
//  Copyright (c) 2015 Nyan Software. All rights reserved.
//

import Cocoa
import ReactiveCocoa

class MainViewModel {

    private enum FetchState {
        case Initial
        case Fetching
        case Failed
    }
    
    //let didRecognizeAction: Signal<(Int), NoError>.Observer
    let searchAction: Action<String, [String: AnyObject], NSError>
    
    //let didClickSettingsButton: Signal<(), NoError>.Observer

    /*static func makeWithResults(results: Results) -> (
        String,
        effects: SignalProducer<Effect, NoError>)
    {
        
    
    
    }*/
    
    
    
    init(){
    
        //didRecognizeAction = MutableProperty(MainViewModel.makeWithResults(Results.empty).0)
        
        /*didClickSettingsButton = {
            let buffer = SignalProducer<(), NoError>.buffer(1)
            buffer.0
                |> map { _ in .OpenSettings}
                |> start(effectsSink)
            return buffer.1
        }()*/
        
        searchAction = Action { input in
            let queryString = input.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            // TODO: add your IP address here http://whatismyip.com yes I'm that lazy
            let myIP: String = "50.174.9.0"
            let searchURL = NSURL(string: "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=\(queryString)&userip=\(myIP)&rsz=8")!
            let request = NSMutableURLRequest(URL: searchURL)
            request.setValue("http://myToyApp.com", forHTTPHeaderField: "Referer")
            
            return NSURLSession.sharedSession().rac_dataWithRequest(request)
                |> map { data, _ in
                    let dict = NSJSONSerialization.JSONObjectWithData(data, options: .allZeros, error: nil)! as! [String: AnyObject]
                    //println("******\nResponse: \(NSString(data: data, encoding: NSUTF8StringEncoding))")
                    let responseData = (dict["responseData"]! as! [String: AnyObject])
                    //let cursorDict = responseData["cursor"]! as! [String: AnyObject]
                    //let cursor = Cursor(dictionary: cursorDict)
                    //let resultDicts = responseData["results"]! as! [[String: String]]
                    //let results = resultDicts.map { Result(dictionary: $0) }
                    return (responseData)
            }
        }
    
    }
    
    
    
    
    
}