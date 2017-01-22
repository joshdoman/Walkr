//
//  ViewController.swift
//  PennApps17S
//
//  Created by Arnav Jagasia on 1/20/17.
//  Copyright © 2017 Arnav Jagasia. All rights reserved.
//

import UIKit
import Firebase

@objc
protocol RegisterControllerDelegate {
    func handleBack()
    func handleNext()
}

class RegisterController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var registerPhotoCell: RegisterPhotoCell?
    var registerUserNameCell: RegisterUserNameCell?
    var registerUserCell: RegisterUserCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        registerCells()
        
        //subviews
        view.addSubview(collectionView)
        setUpCollectionView()
        view.addSubview(backArrow)
        setUpBackArrow()
    }
    
    //Views
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        cv.dataSource = self
        cv.delegate = self
        
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false //disables scrolling
        cv.isPagingEnabled = true //makes the cells snap (paging behavior)
        return cv
    }()
    
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
    
    //Set Up Colletion View
    var currentPage = 0
    let registerUserNameCellId = "registerUserNameCellId"
    let registerUserCellId = "registerUserCellId"
    let registerPhotoCellId = "registerPhotoCellId"
    let successId = "successId"
    
    var userCell: RegisterUserCell?
    
    private func registerCells() {
        collectionView.register(RegisterUserNameCell.self, forCellWithReuseIdentifier: registerUserNameCellId)
        collectionView.register(RegisterUserCell.self, forCellWithReuseIdentifier: registerUserCellId)
        collectionView.register(RegisterPhotoCell.self, forCellWithReuseIdentifier: registerPhotoCellId)
        collectionView.register(SuccessCell.self, forCellWithReuseIdentifier: successId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height) //makes cell size of frame
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: registerUserNameCellId, for: indexPath) as! RegisterUserNameCell
            cell.registerController = self
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: registerUserCellId, for: indexPath) as! RegisterUserCell
            cell.registerController = self
            return cell
        } else if indexPath.item == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: registerPhotoCellId, for: indexPath) as! RegisterPhotoCell
            cell.registerController = self
            registerPhotoCell = cell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: successId, for: indexPath)
            return cell
        }
    }
    
    func setUpCollectionView() {
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    //Image Picking 
    func showImagePicker() {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
    
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            registerPhotoCell?.profileImageView.image = selectedImage
            registerPhotoCell?.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }

    //Other functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func resignAllFirstResponders() {
        registerUserNameCell?.nameTextField.resignFirstResponder()
        registerUserCell?.emailTextField.resignFirstResponder()
        registerUserCell?.passwordTextField.resignFirstResponder()
    }
    
    //Registration Process
    func registerNewUser(email: String?, password: String?, name: String?, phoneNumber: String?, profilePicture: UIImage?) {
        guard let email = email, let password = password, let name = name, let phoneNumber = phoneNumber, let profilePicture = profilePicture else { return }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid, let image = self.registerPhotoCell?.image else {
                return
            }
            
            //successfully authenticated user
            let imageName = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
            if let uploadData = UIImageJPEGRepresentation(image, 0.3) {
                
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        let values = ["name": name, "email": email, "phone": phoneNumber, "imageUrl": profileImageUrl]
                        self.registerUserInfoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                    }
                })
            }
        })
    }
    
    private func registerUserInfoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference()
        
        let usersReference = ref.child("users").child(uid) //make users reference
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref)
            in
            
            if err != nil {
                print(err!)
                return
            }

            //perform segue
            let user = User(uid: uid, name: values["name"] as! String, imageUrl: values["imageUrl"] as! String?, phone: values["phone"] as! String)
            User.current = user
            
            let mc = MainContainerViewController()
            mc.modalTransitionStyle = .crossDissolve
            self.present(mc, animated: true, completion: nil)
        })
    }
    
    func signInNewUser(email: String?, password: String?) {
        
    }



}

extension RegisterController: RegisterControllerDelegate {
    func handleBack() {
        resignAllFirstResponders()
        if (currentPage != 0) {
            currentPage -= 1
        }
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func handleNext() {
        resignAllFirstResponders()
        currentPage += 1
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if (currentPage == 3) {
            
            //Collect Name and Phone Number
            let indexPathZero = IndexPath(item: 0, section: 0)
            let RegisterUserNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: registerUserNameCellId, for: indexPathZero) as! RegisterUserNameCell
            let usersName = RegisterUserNameCell.nameTextField.text
            let usersPhoneNumber = RegisterUserNameCell.phoneTextField.text
            
            //Collect Email and Password
            let indexPathOne = IndexPath(item: 1, section: 0)
            let RegisterUserCell = collectionView.dequeueReusableCell(withReuseIdentifier: registerUserCellId, for: indexPathOne) as! RegisterUserCell
            let usersEmail = RegisterUserCell.emailTextField.text
            let usersPassword = RegisterUserCell.passwordTextField.text
            
            //Collect Prof Pic
            let indexPathTwo = IndexPath(item: 2, section: 0)
            let RegisterPhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: registerPhotoCellId, for: indexPathTwo) as! RegisterPhotoCell
            let usersProfilePicture = RegisterPhotoCell.profileImageView.image
            
            //Register New User
            registerNewUser(email: usersEmail, password: usersPassword, name: usersName, phoneNumber: usersPhoneNumber, profilePicture: usersProfilePicture)
            
            //accelerating animation (looks native)
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.view.layoutIfNeeded() //need to call if want to animate constraint change
                
            }, completion: nil)
        }
    }
    
}

