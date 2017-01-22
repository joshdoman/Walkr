//
//  RegisterUserCell.swift
//  PennApps17S
//
//  Created by Arnav Jagasia on 1/20/17.
//  Copyright © 2017 Arnav Jagasia. All rights reserved.
//

import UIKit

class RegisterUserCell: UICollectionViewCell {
    var delegate: RegisterControllerDelegate?
    var registerController: RegisterController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        //subviews
        addSubview(inputsContainerView)
        setUpInputsContainerView()
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        setUpTextFields()
        
        addSubview(topView)
        setUpTopView()
        topView.addSubview(titleView)
        setUpTitleView()
        
        addSubview(nextButton)
        setUpNextButton()
        addSubview(backButton)
        setUpBackButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Subviews
    
    //Inputs ContainerView
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220, green: 220, blue: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    func setUpInputsContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo: centerYAnchor, constant: -150).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    //Top View
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setUpTopView() {
        topView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        topView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        topView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    //Title View
    let titleView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "walkrlogo")
        return imageView
    }()
    
    func setUpTitleView() {
        titleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleView.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 40).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        titleView.widthAnchor.constraint(equalToConstant: 210).isActive = true
    }
    
    //Text Fields
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.keyboardType = UIKeyboardType.emailAddress
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 83, green: 35, blue: 75)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    func setUpTextFields() {

        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
    
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    
        //need x, y, height constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
    }

    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 83, green: 35, blue: 75)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setUpNextButton() {
        nextButton.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 10).isActive = true
        nextButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 3/7).isActive = true
        nextButton.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
    }
    
    func handleNext() {
        print("here")
        resignFirstResponder()
        registerController?.handleNext()
    }
    
    override func resignFirstResponder() -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
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
        backButton.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 3/7).isActive = true
        backButton.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
    }
    
    func handleBack() {
        registerController?.handleBack()
    }
}





