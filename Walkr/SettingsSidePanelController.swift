//
//  SettingsSidePanelController.swift
//  Walkr
//
//  Created by Josh Doman on 1/20/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import UIKit
import Firebase

class SettingsSidePanelController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 52, g: 61, b: 70)
        
        setupViews()
    }
    
    func setupViews() {
        //*------- Subviews -------* //
        
        view.addSubview(profileImageView)
        setUpProfileImageView()
        
        view.addSubview(nameTextView)
        setUpNameTextView()
        
        view.addSubview(walkerModeView)
        setUpWalkerModeView()
        
        view.addSubview(walkerModeSwitch)
        setUpWalkerModeSwitch()
        
        view.addSubview(logoutButton)
        setUpLogoutButton()
        
        //phone
        view.addSubview(phoneButton)
        setUpPhoneButton()
    }
    
    //subviews
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Profile")
        return imageView
    }()
    
    func setUpProfileImageView() {
        profileImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        profileImageView.topAnchor
            .constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    let nameTextView: UILabel = {
        let label = UILabel()
        label.text = "USER's NAME"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpNameTextView() {
        nameTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        nameTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        nameTextView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        nameTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let walkerModeView: UILabel = {
        let label = UILabel()
        label.text = "Walkr Mode"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpWalkerModeView() {
        walkerModeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        walkerModeView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 10).isActive = true
        walkerModeView.widthAnchor.constraint(equalTo: nameTextView.widthAnchor, multiplier: 2/3).isActive = true
        walkerModeView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    let walkerModeSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .blue
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()
    
    func setUpWalkerModeSwitch() {
        walkerModeSwitch.leftAnchor.constraint(equalTo: walkerModeView.rightAnchor).isActive = true
        walkerModeSwitch.centerYAnchor.constraint(equalTo: walkerModeView.centerYAnchor).isActive = true
        walkerModeSwitch.widthAnchor.constraint(equalTo: walkerModeView.widthAnchor, multiplier: 1/3).isActive = true
        walkerModeSwitch.heightAnchor.constraint(equalTo: walkerModeView.heightAnchor).isActive = true
        
    }
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(r: 112, g: 138, b: 144)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    func setUpLogoutButton() {
        logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    
    lazy var phoneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.setImage(UIImage(named: "Profile"), for: .normal)
        //button.addTarget(self, action: #selector(handlePhoneCall), for:.touchUpInside)
        return button
    }()
    
    
    func setUpPhoneButton() {
        phoneButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        phoneButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        phoneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        phoneButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func handlePhoneCall() {
        print("123")
        guard let number = URL(string: "telprompt://" + "3195946488") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
        print("call done")
    }
    
    func handleLogout() {

        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }

        self.dismiss(animated: true, completion: nil)
    }
    
}
