//
//  Delegates.swift
//  Walkr
//
//  Created by Josh Doman on 1/20/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import Foundation

@objc
protocol CenterViewControllerDelegate {
    @objc optional func toggleLeftPanel()
    @objc optional func toggleRightPanel()
    @objc optional func collapseSidePanels()
}
