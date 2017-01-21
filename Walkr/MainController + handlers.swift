//
//  MainController + handlers.swift
//  Walkr
//
//  Created by Josh Doman on 1/20/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

extension MainController {
    
    func handleRequest() {
        guard let user = User.current else {
            return
        }
        
        let lattitude = 3.234
        let longitude = 2.632
        let uid = user.uid
        
        
    }
    
    func handleHelp() {
    }
    
    func handleShow() {
        delegate?.toggleLeftPanel!()
    }
    
}
