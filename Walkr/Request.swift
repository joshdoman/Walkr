//
//  Request.swift
//  Walkr
//
//  Created by Josh Doman on 1/20/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import UIKit
import CoreLocation

class Request: NSObject {
    
    var location: CLLocationCoordinate2D
    var destination: CLLocationCoordinate2D
    let requester: User!
    var walker: User?
    
    var fromId: String?
    var timestamp: NSNumber?
    var startLat: String?
    var startLong: String?
    var endLat: String?
    var endLong: String?
    
    init(location: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, requester: User, walker: User?) {
        self.location = location
        self.destination = destination
        self.requester = requester
        self.walker = walker
    }
    
    public func getRequesterName() -> String {
        return requester.name
    
    }
}

class RoughRequest: NSObject {
    var fromId: String?
    var timestamp: String?
    var startLat: String?
    var startLong: String?
    var endLat: String?
    var endLong: String?
}
