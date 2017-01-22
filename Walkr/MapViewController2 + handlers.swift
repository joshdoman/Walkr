//
//  MapViewController2 + handlers.swift
//  Walkr
//
//  Created by Josh Doman on 1/21/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import CoreLocation
import UIKit
import Firebase

extension MapViewController2 {
    func handleBuddyUp() {
        print("BuddyUp!")
        
        someoneRequesting = true
        setupBottomBar(bar: bottomBar)
        
        //sendRequest()
    }
    
    func handleYes() {
        print("yes")
    }
    
    func handleNo() {
        print("no")
        someoneRequesting = false
        setupBottomBar(bar: bottomBar)
    }
    
    func handleShow() {
        delegate?.toggleLeftPanel!()
    }
}
