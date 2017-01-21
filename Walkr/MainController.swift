//
//  ViewController.swift
//  Walkr
//
//  Created by Josh Doman on 1/20/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import UIKit
import Firebase

class MainController: UIViewController {
    
    lazy var requestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Request", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handleRequest), for: .touchUpInside)
        return button
    }()
    
    lazy var helpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Help", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handleHelp), for: .touchUpInside)
        return button
    }()
    
    var delegate: CenterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationController()
        setupViews()
    }
    
    private func setupNavigationController() {
        let image = UIImage(named: "Menu")
        navigationItem.leftBarButtonItem = UIBarButtonItem.itemWith(colorfulImage: image, target: self, action: #selector(handleShow))
    }
    
    private func setupViews() {
        view.addSubview(requestButton)
        view.addSubview(helpButton)
        
        _ = requestButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 16, rightConstant: 0, widthConstant: 100, heightConstant: 50)
        
        _ = helpButton.anchor(nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 16, widthConstant: 100, heightConstant: 50)
    }
    
}

