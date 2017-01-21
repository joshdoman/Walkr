//
//  Request.swift
//  Walkr
//
//  Created by Josh Doman on 1/20/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import UIKit

class Request: NSObject {
    
    let startingLatitude: Double!
    let startingLongitude: Double!
    let endingLatitude: Double!
    let endingLongitude: Double!
    let requester: User!
    let helper: User!
    
    init(startLat: Double, startLong: Double, endLat: Double, endLong: Double, requester: User, helper: User) {
        startingLatitude = startLat
        startingLongitude = startLong
        endingLatitude = endLat
        endingLongitude = endLong
        self.requester = requester
        self.helper = helper
    }
}
