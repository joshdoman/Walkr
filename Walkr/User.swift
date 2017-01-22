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
    var imageUrl: String!
    var phone: String!
    
    init(uid: String, name: String, imageUrl: String?, phone: String) {
        self.uid = uid
        self.name = name
        self.imageUrl = imageUrl
        self.phone = phone
    }
    
    static var current: User?
    
}
