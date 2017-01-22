//
//  RequesterView.swift
//  Walkr
//
//  Created by Arnav Jagasia on 1/21/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import UIKit

class RequesterView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(r: 83, g: 35, b: 74)
        
        //subviews
        addSubview(profilepictureView)
        setUpProfilePictureView()
        addSubview(nameView)
        setUpNameView()
        addSubview(phoneButton)
        setUpPhoneButton()
        addSubview(phoneTextLabel)
        setUpPhoneTextLabel()
        addSubview(cancelButton)
        setUpCancelButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Subviews
    
    let profilepictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Profile")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 45
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func setUpProfilePictureView() {
        profilepictureView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        profilepictureView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profilepictureView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        profilepictureView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    let nameView: UILabel = {
        let label = UILabel()
        label.text = "Doug Stamper" //requester name
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpNameView() {
        nameView.leftAnchor.constraint(equalTo: profilepictureView.rightAnchor, constant:15).isActive = true
        nameView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
    }
    
    let phoneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "Phone"), for: .normal)
        button.addTarget(self, action: #selector(handlePhoneCall), for:.touchUpInside)
        return button
    }()
    
    func setUpPhoneButton() {
        phoneButton.leftAnchor.constraint(equalTo: nameView.leftAnchor).isActive = true
        phoneButton.centerYAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20).isActive = true
        phoneButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        phoneButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    var phoneNumber: String = "3195946488"
    
    func handlePhoneCall() {
        print("123")
        guard let number = URL(string: "telprompt://" + "\(phoneNumber)") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
        print("call done")
    }
    
    let phoneTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Call"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpPhoneTextLabel() {
        phoneTextLabel.leftAnchor.constraint(equalTo: phoneButton.rightAnchor, constant: 5).isActive = true
        phoneTextLabel.centerYAnchor.constraint(equalTo: phoneButton.centerYAnchor).isActive = true
    }
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "Cancel"), for: .normal)
        button.addTarget(self, action: #selector(handleCancelWalkr), for:.touchUpInside)
        return button
    }()
    
    func setUpCancelButton() {
        cancelButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func handleCancelWalkr() {
        print("cancel walker")
    }
}
