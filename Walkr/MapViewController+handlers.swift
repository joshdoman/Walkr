//
//  MapViewController+handlers.swift
//  Walkr
//
//  Created by Josh Doman on 1/21/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//
import CoreLocation
import UIKit
import Firebase

extension MapViewController {
    func handleBuddyUp() {
        sendRequest()
    }
    
    func handleYes() {
        print("yes")
    }
    
    func handleNo() {
        bottomState = .buddyUp
        updateBottomBar()
    }
    
    //make sure to set state before
    func updateBottomBar() {
        buddyUpButton.isHidden = true
        yesButton.isHidden = true
        noButton.isHidden = true
        walkrView.isHidden = true
        requesterView.isHidden = true
        
        bottomBarHeightAnchor?.constant = 60
        
        switch bottomState {
        case .buddyUp :
            buddyUpButton.isHidden = false
        case .confirm :
            yesButton.isHidden = false
            noButton.isHidden = false
        case .showRequester :
            bottomBarHeightAnchor?.constant = 120
            requesterView.isHidden = false
        case .showWalkr :
            bottomBarHeightAnchor?.constant = 120
            walkrView.isHidden = false
        }
    }
    
    func handleShow() {
        delegate?.toggleLeftPanel!()
    }
    
    func handleWalkrCanHelp() {
        
    }
    
    func handleShowRequester() {
        
    }
}
