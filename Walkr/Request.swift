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
    
    let requestId: String!
    var location: CLLocationCoordinate2D
    var destination: CLLocationCoordinate2D
    let requester: User!
    var walker: User?
    
    init(requestId: String, location: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, requester: User, walker: User?) {
        self.requestId = requestId
        self.location = location
        self.destination = destination
        self.requester = requester
        self.walker = walker
    }
    
    public func getRequesterName() -> String {
        return requester.name
    
    }
}
