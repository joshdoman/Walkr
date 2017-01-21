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
    let imageUrl: String!
    
    init(name: String, imageUrl: String) {
        self.name = name
        self.imageUrl = imageUrl
    }
    
}
