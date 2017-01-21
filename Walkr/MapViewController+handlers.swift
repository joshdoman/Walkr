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
        print("BuddyUp!")
        
        someoneRequesting = true
        setupBottomBar(bar: bottomBar)
        
        sendRequest()
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
    
    func sendRequest() {
        let destination = CLLocationCoordinate2D(latitude: 39.953480 , longitude: -75.191414)
        
        guard let user = User.current, let location = currentLocation else {
            return
        }
                
        let request = Request(location: location, destination: destination, requester: user, walker: nil)
        
        let ref = FIRDatabase.database().reference().child("requests")
        let childRef = ref.childByAutoId()
        let fromId = user.uid
        
        let timestamp = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        let values: [String: AnyObject] = ["fromId": fromId as AnyObject, "timestamp": timestamp as AnyObject, "startLat": location.latitude as AnyObject, "startLong": location.longitude as AnyObject, "endLat": destination.latitude as AnyObject, "endLong": destination.longitude as AnyObject]
        
        childRef.updateChildValues(values) { (error, ref) in
            
            if error != nil {
                print(error!)
                return
            }
        }
        
        let requestId = childRef.key
        FIRDatabase.database().reference().child("outstanding-requests").updateChildValues([requestId: 1])
    }
}
