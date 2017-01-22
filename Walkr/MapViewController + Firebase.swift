//
//  MapViewController + Firebase.swift
//  Walkr
//
//  Created by Josh Doman on 1/21/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

extension MapViewController {
    
    func sendRequest(destination: CLLocationCoordinate2D) {        
        guard let user = User.current, let location = currentLocation else {
            return
        }
        
        let ref = FIRDatabase.database().reference().child("requests")
        let childRef = ref.childByAutoId()
        let fromId = user.uid
        
        let timestamp = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        let values: [String: AnyObject] = ["fromId": fromId as AnyObject, "timestamp": timestamp as AnyObject, "startLat": location.latitude as AnyObject, "startLong": location.longitude as AnyObject, "endLat": destination.latitude as AnyObject, "endLong": destination.longitude as AnyObject]
        
        childRef.updateChildValues(values) { (error, ref) in
            
            if error != nil {
                print(error!)
                return
            }
        }
        
        let requestId = childRef.key
        FIRDatabase.database().reference().child("outstanding-requests-by-user").child(user.uid).updateChildValues([requestId: 1])
        
        let request = Request(requestId: requestId, location: location, destination: destination, requester: user, walker: nil)
        self.request = request
        
        showPendingView()
        checkIfBeenHelped()
    }
    
    func checkIfSomeoneRequesting() {
        FIRDatabase.database().reference().child("outstanding-requests-by-user").observeSingleEvent(of: .childAdded, with: { (snapshot) in
            let fromId = snapshot.key
            print(fromId)
            
            FIRDatabase.database().reference().child("outstanding-requests-by-user").child(fromId).observeSingleEvent(of: .childAdded, with: { (snapshot) in

                let requestId = snapshot.key
                FIRDatabase.database().reference().child("requests").child(requestId).observeSingleEvent(of: .value, with: { (snapshot) in
                    print(snapshot.value)
                    guard let dictionary = snapshot.value as? [String: AnyObject] else {
                        return
                    }
                    
                    let startLocation = CLLocationCoordinate2D(latitude: dictionary["startLat"] as! Double, longitude: dictionary["startLong"] as! Double)
                    let endLocation = CLLocationCoordinate2D(latitude: dictionary["endLat"] as! Double, longitude: dictionary["endLong"] as! Double)
                    let fromId = dictionary["fromId"] as! String
                    
                    if fromId == User.current?.uid {
                        self.showPendingView()
                        return
                    }
                    
                    FIRDatabase.database().reference().child("users").child(fromId).observeSingleEvent(of: .value, with: { (snapshot) in
                        guard let dictionary = snapshot.value as? [String: AnyObject] else {
                            return
                        }
                        
                        let name = dictionary["name"] as! String
                        let imageUrl = dictionary["imageUrl"] as! String
                        let phone = dictionary["phone"] as! String
                        
                        let user = User(uid: fromId, name: name, imageUrl: imageUrl, phone: phone)
                        
                        let request = Request(requestId: requestId, location: startLocation, destination: endLocation, requester: user, walker: nil)
                        
                        self.request = request
                        self.setupMapForRequest(request: request)
                    })
                })
            }, withCancel: nil)
        })
    }
    
    func showPendingView() {
        pendingView.isHidden = false
    }
    
    func checkIfBeenHelped() {
        //FIRDatabase.database().reference().child("outstanding-requests").obse
        guard let uid = User.current?.uid else {
            return
        }

        FIRDatabase.database().reference().child("outstanding-requests-by-user").child(uid).observeSingleEvent(of: .childAdded, with: { (snapshot) in
            
            let requestId = snapshot.key
            
            self.checkIfRequestGetsWalkr(for: requestId)
            
        })
    }
    
    fileprivate func checkIfRequestGetsWalkr(for requestId: String) {
        firebaseHandlers.append(FIRDatabase.database().reference().child("requests").child(requestId).observe(.childAdded, with: { (snapshot) in
            
            if snapshot.key != "helperId" {
                return
            }
            
            FIRDatabase.database().reference().child("requests").child(requestId).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: AnyObject] else {
                    return
                }
                
                if let walkerId = dictionary["fromId"] as? String {
                    
                    FIRDatabase.database().reference().child("users").child(walkerId).observeSingleEvent(of: .value, with: { (snapshot) in
                        guard let dictionary = snapshot.value as? [String: AnyObject] else {
                            return
                        }
                        
                        let name = dictionary["name"] as! String
                        let imageUrl = dictionary["imageUrl"] as! String
                        let phone = dictionary["phone"] as! String
                        
                        let user = User(uid: walkerId, name: name, imageUrl: imageUrl, phone: phone)
                        
                        self.showWalkrView(for: user)
                    })
                }
            })
        }))
    }
    
    func helpRequester(for request: Request) {
        guard let uid = User.current?.uid, let requesterId = request.requester.uid,
            let requestId = request.requestId, let user = request.requester else {
            return
        }

        
        FIRDatabase.database().reference().child("outstanding-requests-by-user").child(requesterId).removeValue()
        FIRDatabase.database().reference().child("requests-being-helped").updateChildValues([requestId: "1"])
        
        FIRDatabase.database().reference().child("requests").child(request.requestId).updateChildValues(["helperId": uid])
        
        showRequesterView(for: user)
    }
    
    func showWalkrView(for user: User) {
        bottomState = .showWalkr
        pendingView.isHidden = true
        updateBottomBar()
        walkrView.user = user
        
        if let requestId = request?.requestId {
            checkIfRequestCancelled(for: requestId)
        }
    }
    
    func showRequesterView(for user: User) {
        bottomState = .showRequester
        requesterView.user = user
        updateBottomBar()
        
        if let requestId = request?.requestId {
            checkIfRequestCancelled(for: requestId)
        }
    }
    
    func cancelRequest(for requestId: String) {
        guard let uid = User.current?.uid else {
            return
        }
        
        FIRDatabase.database().reference().child("outstanding-requests-by-user").child(uid).removeValue()
        FIRDatabase.database().reference().child("requests-being-helped").child(requestId).removeValue()
        FIRDatabase.database().reference().child("requests").child(requestId).removeValue()
        
        checkIfSomeoneRequesting()
        
        handleReset()
    }
    
    func checkIfRequestCancelled(for requestId: String) {
        FIRDatabase.database().reference().child("request").child(requestId).observeSingleEvent(of: .childRemoved, with: { (snapshot) in
            self.handleReset()
        })
    }
    
}
