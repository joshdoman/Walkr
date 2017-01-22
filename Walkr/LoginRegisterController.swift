//
//  LoginRegisterController.swift
//  PennApps17S
//
//  Created by Arnav Jagasia on 1/21/17.
//  Copyright © 2017 Arnav Jagasia. All rights reserved.
//

import UIKit

class LoginRegisterController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(titleView)
        setUpTitleView()
        
        view.addSubview(logInButton)
        setUpLogInButton()
        view.addSubview(registerButton)
        setUpRegisterButton()
    }


    //Title View
    
    let titleView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "walkrlogo")
        return imageView
    }()
    
    func setUpTitleView() {
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        titleView.widthAnchor.constraint(equalToConstant: 240).isActive = true
    }
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 120, green: 120, blue: 120)
        button.addTarget(self, action: #selector(showRegisterController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setUpRegisterButton() {
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func showRegisterController(){
        present(RegisterController(), animated: true, completion: nil)
    }

    let logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 83, green: 35, blue: 75)
        button.addTarget(self, action: #selector(showLogInController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setUpLogInButton() {
        logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        logInButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func showLogInController(){
        present(LogInController(), animated: true, completion: nil)
    }
    
   
}
