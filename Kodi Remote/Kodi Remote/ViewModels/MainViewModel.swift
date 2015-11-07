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
    //let searchAction: Action<String, [String: AnyObject], NSError>
    
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
        
    }
    
    
    
    
    
}