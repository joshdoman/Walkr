//
//  walkrView.swift
//  Walkr
//
//  Created by Arnav Jagasia on 1/21/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import UIKit

class WalkrView: UIView {
    
    var user: User? {
        didSet {
            nameView.text = user?.name
        }
    }
    
    var delegate: BottomViewDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        //backgroundColor = UIColor(r: 83, g: 35, b: 74)
        backgroundColor = UIColor(r: 108, g: 153, b: 204)
        //subviews
        addSubview(profilepictureView)
        setUpProfilePictureView()
        addSubview(nameView)
        setUpNameView()
        addSubview(ratingView)
        setUpRatingView()
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
        label.text = "Frank J. Underwood" //walkr name
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpNameView() {
        nameView.leftAnchor.constraint(equalTo: profilepictureView.rightAnchor, constant:15).isActive = true
        nameView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
    }
    
    let ratingView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "Five Stars")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setUpRatingView() {
        ratingView.leftAnchor.constraint(equalTo: nameView.leftAnchor).isActive = true
        ratingView.topAnchor.constraint(equalTo: nameView.bottomAnchor).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    lazy var phoneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "Phone"), for: .normal)
        button.addTarget(self, action: #selector(handlePhoneCall), for:.touchUpInside)
        return button
    }()
    
    func setUpPhoneButton() {
        phoneButton.leftAnchor.constraint(equalTo: profilepictureView.rightAnchor, constant: 15).isActive = true
        phoneButton.centerYAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 20).isActive = true
        phoneButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        phoneButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    func handlePhoneCall() {
        print("123")
        guard let number = user?.phone else { return }
        guard let numberUrl = URL(string: "telprompt://" + "\(number)") else { return }
        UIApplication.shared.open(numberUrl, options: [:], completionHandler: nil)
        print("call done")
    }
    
    let phoneTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Call your Walkr"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpPhoneTextLabel() {
        phoneTextLabel.leftAnchor.constraint(equalTo: phoneButton.rightAnchor, constant: 5).isActive = true
        phoneTextLabel.centerYAnchor.constraint(equalTo: phoneButton.centerYAnchor).isActive = true
    }
    
    lazy var cancelButton: UIButton = {
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
        delegate?.handleBottomCancel()
    }
}
