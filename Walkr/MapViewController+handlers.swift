//
//  MapViewController+handlers.swift
//  Walkr
//
//  Created by Josh Doman on 1/21/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

extension MapViewController {
    func handleBuddyUp() {
        print("BuddyUp!")
        someoneRequesting = true
        setupBottomBar(bar: bottomBar)
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
        print(delegate == nil)
        delegate?.toggleLeftPanel!()
    }
}
