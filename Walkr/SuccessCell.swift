//
//  SuccessCell.swift
//  PennApps17S
//
//  Created by Arnav Jagasia on 1/20/17.
//  Copyright © 2017 Arnav Jagasia. All rights reserved.
//

import UIKit

class SuccessCell: UICollectionViewCell {
    var delegate: RegisterControllerDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(activityIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let actInd = UIActivityIndicatorView()
        actInd.color = .black
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 60.0, height: 60.0)
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        actInd.startAnimating()
        actInd.translatesAutoresizingMaskIntoConstraints = false
        return actInd
    }()
    
    func setUpActivityIndicator() {
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

}
