//
//  User.swift
//  Walkr
//
//  Created by Josh Doman on 1/20/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import UIKit

class User: NSObject {
    
    let name: String!
    let uid: String!
    let imageUrl: String!
    
    init(uid: String, name: String, imageUrl: String) {
        self.uid = uid
        self.name = name
        self.imageUrl = imageUrl
    }
    
    static var current: User?
    
}
