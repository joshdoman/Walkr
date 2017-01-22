//
//  RegisterPhotoCell.swift
//  PennApps17S
//
//  Created by Arnav Jagasia on 1/20/17.
//  Copyright © 2017 Arnav Jagasia. All rights reserved.
//

import UIKit

class RegisterPhotoCell: UICollectionViewCell, UIImagePickerControllerDelegate {
    
    var delegate: RegisterControllerDelegate?
    var registerController: RegisterController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        setUpImageView()
        addSubview(captionLabel)
        setUpCaptionLabel()
        
        addSubview(nextButton)
        setUpNextButton()
        addSubview(backButton)
        setUpBackButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //Subview - profileImageView
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profilepicture")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var image: UIImage?
    
    func setUpImageView() {
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func handleSelectProfileImageView() {
        registerController?.showImagePicker()
    }
    
    //subview caption text
    let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Select a Profile Image"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpCaptionLabel() {
        captionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        captionLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15).isActive = true
        captionLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        captionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 83, green: 35, blue: 75)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setUpNextButton() {
        nextButton.rightAnchor.constraint(equalTo: captionLabel.rightAnchor, constant: -50).isActive = true
        nextButton.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 10).isActive = true
        nextButton.widthAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 3/7).isActive = true
        nextButton.heightAnchor.constraint(equalTo: captionLabel.heightAnchor).isActive = true
    }
    
    func handleNext() {
        print("here")
        registerController?.handleNext()
    }
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 83, green: 35, blue: 75)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setUpBackButton() {
        backButton.leftAnchor.constraint(equalTo: captionLabel.leftAnchor, constant: 50).isActive = true
        backButton.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 3/7).isActive = true
        backButton.heightAnchor.constraint(equalTo: captionLabel.heightAnchor).isActive = true
    }
    
    func handleBack() {
        registerController?.handleBack()
    }

    

}
