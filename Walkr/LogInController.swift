//
//  LogInController.swift
//  PennApps17S
//
//  Created by Arnav Jagasia on 1/21/17.
//  Copyright © 2017 Arnav Jagasia. All rights reserved.
//

import UIKit
import Firebase

class LogInController: UIViewController {
    var registerUserNameCell: RegisterUserNameCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white //UIColor(red: 108, green: 153, blue: 204)
        
        //subviews
        view.addSubview(inputsContainerView)
        setUpInputsContainerView()
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        setUpTextFields()
        
        view.addSubview(topView)
        setUpTopView()
        topView.addSubview(titleView)
        setUpTitleView()
        
        view.addSubview(LogInButton)
        setUpLogInButton()
        
        view.addSubview(backArrow)
        setUpBackArrow()

        
    }
    
    //back arrow
    lazy var backArrow: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "backarrow"), for: .normal)
        button.addTarget(self, action: #selector(showLoginRegisterController), for: .touchUpInside)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    func setUpBackArrow() {
        backArrow.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 7).isActive = true
        backArrow.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        backArrow.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backArrow.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func showLoginRegisterController() {
        present(LoginRegisterController(), animated: false, completion: nil)
    }

    
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
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    //Top View
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setUpTopView() {
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        topView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        topView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
    
    
    let LogInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 83, green: 35, blue: 75)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setUpLogInButton() {
        LogInButton.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        LogInButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 10).isActive = true
        LogInButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        LogInButton.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4).isActive = true
    }
    
    func handleLogIn(){
        let email = emailTextField.text
        let password = passwordTextField.text
        logInUser(email: email, password: password)
    }

    func logInUser(email: String?, password: String?) {
        guard let email = email, let password = password else {
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {
            (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            self.getUserAndSegue()

        })
    }
    
    func getUserAndSegue() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {
                return
            }
            
            let name = dictionary["name"] as! String
            let imageUrl = dictionary["imageUrl"] as! String
            let phone = dictionary["phone"] as! String
            
            let user = User(uid: uid, name: name, imageUrl: imageUrl, phone: phone)
            User.current = user
            
            let mc = MainContainerViewController()
            mc.modalTransitionStyle = .crossDissolve
            self.present(mc, animated: true, completion: nil)
        })
    }
}
