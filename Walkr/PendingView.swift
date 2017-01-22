//
//  PendingView.swift
//  Walkr
//
//  Created by Arnav Jagasia on 1/21/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import UIKit

protocol PendingViewDelegate {
    func handleCancel()
}

class PendingView: UIView {
    
    var delegate: PendingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0, alpha: 0.8)
        addSubview(activityIndicator)
        setUpActivityIndicator()
        addSubview(cancelButton)
        setUpCancelButton()
        addSubview(textLabel)
        setUpTextLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Subviews
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Searching for Walkrs"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32.0)
        return label
    }()
    
    func setUpTextLabel() {
        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: activityIndicator.topAnchor, constant: -20).isActive = true
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let actInd = UIActivityIndicatorView()
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
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel Request", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    func setUpCancelButton() {
        cancelButton.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -120).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func handleCancel() {
        delegate?.handleCancel()
    }
    
}
