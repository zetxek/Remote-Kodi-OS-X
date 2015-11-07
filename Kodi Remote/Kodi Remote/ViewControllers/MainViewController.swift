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
    
    //private
    private let model: MainViewModel = MainViewModel()
    private weak var delegate: MainViewControllerDelegate?
    
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

    @IBAction func btnClick(sender: AnyObject) {
        
        flashHighlightedButtonThen {
            if let action : NSString = self.btnActions[sender as! NSButton]{
                self.apiManager.sendMessage(action as String)
            }
        }

        
        /*if let action : NSString = btnActions[sender as! NSButton]{
            apiManager.sendMessage(action as String)
        }*/
        
    }
    
    /*func apiCall(action : String){
        
        let searchResults = action
            |> flatMap(.Latest) { query in
                let URLRequest = self.searchRequestWithEscapedQuery(query)
                return NSURLSession.sharedSession().rac_dataWithRequest(URLRequest)
            }
            |> map { data, URLResponse in
                let string = String(data: data, encoding: NSUTF8StringEncoding)!
                return parseJSONResultsFromString(string)
            }
            |> observeOn(UIScheduler())

    
    }*/

    
    func flashHighlightedButtonThen(callback: () -> ()) {
        
        let mainQueue = dispatch_get_main_queue()
        let toggleInterval = Int64(NSEC_PER_SEC) / 20
        let numberOfToggles: Int64 = 3
        
        for i: Int64 in 0...numberOfToggles {
            let time = dispatch_time(DISPATCH_TIME_NOW, toggleInterval * i)
            dispatch_after(time, mainQueue) {
                if i < numberOfToggles {
                    //change
                } else {
                    //end
                    callback()
                }
            }
        }
    }
    
}

protocol MainViewControllerDelegate: NSObjectProtocol {
    func mainViewControllerDidChangeFittingSize(mainViewController: MainViewController)
}
