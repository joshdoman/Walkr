//
//  MapViewController.swift
//  Penn
//
//  Created by Jack O'Donnell on 1/20/17.
//  Copyright © 2017 Jack O'Donnell. All rights reserved.
//

//import UIKit
//import GoogleMaps
//import Firebase
//import GooglePlaces
//
//class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
//
//    var map : GMSMapView!
//    var locationManager : CLLocationManager!
//    var currentLocation : CLLocationCoordinate2D? {
//        get {
//            if let location = locationManager.location {
//                return location.coordinate
//            }
//            return nil
//        }
//    }
//    
//    var client: GMSPlacesClient = GMSPlacesClient()
//    
//    var firebaseHandlers: [UInt] = [UInt]()
//    
//    var request: Request?
//    
//    var delegate: CenterViewControllerDelegate?
//    
//    let bottomBar: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .white
//        return view
//    }()
//    
//    lazy var pendingView: PendingView = {
//        let pv = PendingView(frame: self.view.frame)
//        pv.delegate = self
//        pv.isHidden = true
//        return pv
//    }()
//    
//    lazy var buddyUpButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("BuddyUp!", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        button.addTarget(self, action: #selector(handleBuddyUp), for: .touchUpInside)
//        button.backgroundColor = .blue
//        button.isHidden = false
//        return button
//    }()
//    
//    lazy var yesButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Yes", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitleColor(UIColor.green, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
//        button.addTarget(self, action: #selector(handleYes), for: .touchUpInside)
//        button.isHidden = true
//        return button
//    }()
//    
//    lazy var noButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("No", for: .normal)
//        button.setTitleColor(UIColor.red, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
//        button.addTarget(self, action: #selector(handleNo), for: .touchUpInside)
//        button.isHidden = true
//        return button
//    }()
//    
//    lazy var walkrView: WalkrView = {
//        let wv = WalkrView()
//        wv.isHidden = true
//        wv.delegate = self
//        wv.translatesAutoresizingMaskIntoConstraints = false
//        return wv
//    }()
//    
//    lazy var requesterView: RequesterView = {
//        let rv = RequesterView()
//        rv.isHidden = true
//        rv.delegate = self
//        rv.translatesAutoresizingMaskIntoConstraints = false
//        return rv
//    }()
//    
//    var bottomBarHeightAnchor: NSLayoutConstraint?
//    var bottomState: BottomBarState = .buddyUp
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        initLocation()
//        initMap()
//        
//        setupMap()
//        
//        setupNavigationBar()
//        
//        checkIfSomeoneRequesting()
//        
//        view.addSubview(pendingView)
//        
//    }
//    
//
//    
//    func setupMap() {
//        guard let location = self.currentLocation else {
//            return
//        }
//        
//        self.map.camera = GMSCameraPosition.camera(withTarget: location, zoom: 15)
//    }
//    
//    func setupMapForRequest(request: Request) {
//        bottomState = .confirm
//        updateBottomBar()
//        
//        let startLocation = request.location //CLLocationCoordinate2D(latitude: 39.951557 , longitude: -75.193205)
//        let endLocation = request.destination //CLLocationCoordinate2D(latitude: 39.953480 , longitude: -75.191414)
//
//        self.map.addMarker(at: startLocation)
//        self.map.addMarker(at: endLocation)
//        
//        self.getDirections(from: startLocation, to: endLocation, color: UIColor.green)
//        if let location = self.currentLocation {
//            self.getDirections(from: location, to: startLocation, color: UIColor.blue)
//        }
//
//    }
//    
//    func initLocation() {
//        locationManager = CLLocationManager()
//        locationManager.requestWhenInUseAuthorization()
//    }
//
//    func initMap() {
//        map = GMSMapView()
//        map.delegate = self
//        map.settings.myLocationButton = true
//        map.settings.compassButton = true
//        map.isMyLocationEnabled = true
//        
//        self.view.addSubview(map)
//        
//        self.view.addConstraint(
//            NSLayoutConstraint(
//                item: map,
//                attribute: .top,
//                relatedBy: .equal,
//                toItem: self.view,
//                attribute: .top,
//                multiplier: 1,
//                constant: 1
//            )
//        )
//        
//        self.view.addConstraint(
//            NSLayoutConstraint(
//                item: map,
//                attribute: .left,
//                relatedBy: .equal,
//                toItem: self.view,
//                attribute: .left,
//                multiplier: 1,
//                constant: 1
//            )
//        )
//        
//        self.view.addConstraint(
//            NSLayoutConstraint(
//                item: map,
//                attribute: .right,
//                relatedBy: .equal,
//                toItem: self.view,
//                attribute: .right,
//                multiplier: 1,
//                constant: 1
//            )
//        )
//        
//        self.view.addSubview(bottomBar)
//        self.view.addConstraint(
//            NSLayoutConstraint(
//                item: bottomBar,
//                attribute: .left,
//                relatedBy: .equal,
//                toItem: self.view,
//                attribute: .left,
//                multiplier: 1,
//                constant: 1
//            )
//        )
//        
//        self.view.addConstraint(
//            NSLayoutConstraint(
//                item: bottomBar,
//                attribute: .right,
//                relatedBy: .equal,
//                toItem: self.view,
//                attribute: .right,
//                multiplier: 1,
//                constant: 1
//            )
//        )
//        
//        self.view.addConstraint(
//            NSLayoutConstraint(
//                item: bottomBar,
//                attribute: .bottom,
//                relatedBy: .equal,
//                toItem: self.view,
//                attribute: .bottom,
//                multiplier: 1,
//                constant: 1
//            )
//        )
//        
//        bottomBarHeightAnchor = bottomBar.heightAnchor.constraint(equalToConstant: 60)
//        bottomBarHeightAnchor?.isActive = true
//        
//        //bottom of map to top of button
//        self.view.addConstraint(
//            NSLayoutConstraint(
//                item: map,
//                attribute: .bottom,
//                relatedBy: .equal,
//                toItem: bottomBar,
//                attribute: .top,
//                multiplier: 1,
//                constant: 1
//            )
//        )
//        
//        map.translatesAutoresizingMaskIntoConstraints = false
//        
//        setupBottomBar()
//        
//        map.isExclusiveTouch = false
//        map.settings.consumesGesturesInView = false
//        
//        ///###################################
//        let backView = UIView()
//        backView.backgroundColor = .red
//        map.addSubview(backView)
//        map.bringSubview(toFront: backView)
//        
//        _ = backView.anchor(map.topAnchor, left: map.leftAnchor, bottom: nil, right: map.rightAnchor, topConstant: 100, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 300)
//        
//        let searchView = SearchPlaceBar()
//        searchView.delegate = self
//        
//        backView.addSubview(searchView)
//
//        searchView.translatesAutoresizingMaskIntoConstraints = false
//        
//        _ = searchView.anchor(backView.topAnchor, left: backView.leftAnchor, bottom: backView.bottomAnchor, right: backView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//        
//    }
//    
//    func setupBottomBar() {
//        let bar = bottomBar
//        bar.addSubview(noButton)
//        bar.addSubview(yesButton)
//        
//        _ = noButton.anchor(bar.topAnchor, left: bar.leftAnchor, bottom: bar.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//        noButton.widthAnchor.constraint(equalTo: bar.widthAnchor, multiplier: 0.5).isActive = true
//        
//        _ = yesButton.anchor(bar.topAnchor, left: nil, bottom: bar.bottomAnchor, right: bar.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//        yesButton.widthAnchor.constraint(equalTo: bar.widthAnchor, multiplier: 0.5).isActive = true
//        
//        bar.addSubview(buddyUpButton)
//        
//        buddyUpButton.anchorToTop(bar.topAnchor, left: bar.leftAnchor, bottom: bar.bottomAnchor, right: bar.rightAnchor)
//        
//        bottomBar.addSubview(walkrView)
//        bottomBar.addSubview(requesterView)
//        
//        walkrView.anchorToTop(bottomBar.topAnchor, left: bottomBar.leftAnchor, bottom: bottomBar.bottomAnchor, right: bottomBar.rightAnchor)
//        requesterView.anchorToTop(bottomBar.topAnchor, left: bottomBar.leftAnchor, bottom: bottomBar.bottomAnchor, right: bottomBar.rightAnchor)
//    }
//    
//    func setupNavigationBar() {
//        let image = UIImage(named: "Menu")
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem.itemWith(colorfulImage: image, target: self, action: #selector(handleShow))
//        self.title = User.current?.name
//        print(navigationController == nil)
//    }
//    
//    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
//        let view = UIView()
//        view.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
//        view.backgroundColor = UIColor.black
//        return view
//    }
//    
//    func direct(to place: CLLocationCoordinate2D) {
//        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
//            UIApplication.shared.open(
//                URL(string: "comgooglemaps://?saddr=&daddr=\(place.latitude),\(place.longitude)&directionsmode=driving")!,
//                options: [:],
//                completionHandler: { (success) in
//                    print(success)
//                }
//            )
//        }
//        else {
//            print("Can't use comgooglemaps://")
//            UIApplication.shared.open(
//                URL(string: "https://maps.google.com/?q=@\(place.latitude),\(place.longitude)")!,
//                options: [:],
//                completionHandler: { (works) in
//                    print(works)
//                }
//            )
//        }
//    }
//    
////    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
////        //direct(to: current)
////        getDirections(from: current, to: currentUser.location)
////        getDirections(from: currentUser.location, to: currentUser.destination)
////        return true
////
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .authorizedAlways, .authorizedWhenInUse:
//            locationManager.startUpdatingLocation()
//        default:
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
//    
//    func getDirections(request: Request) {
//        getDirections(from: request.location, to: request.destination, color: UIColor.red)
//    }
//    
//    func getDirections(from: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, color: UIColor){
//        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(from.latitude),\(from.longitude)&destination=\(destination.latitude),\(destination.longitude)&key=AIzaSyBrcUvjEBZsRj63gQltNht6aTIYIrFLrj0&mode=walking")
//        let request = URLRequest(url: url!)
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        
//        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
//            
//            do{
//                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                    let selectedRoute = (jsonResult["routes"] as! Array<Dictionary<String, AnyObject>>)[0]
//                    let overViewPolyLine = selectedRoute["overview_polyline"] as! Dictionary<String, AnyObject>
//                    DispatchQueue.main.async {
//                        
//                        self.drawRoute(for: overViewPolyLine, color: color)
//                    }
//                }
//            }
//            catch{
//                
//                print("Somthing wrong")
//            }
//        });
//        
//        // do whatever you need with the task e.g. run
//        task.resume()
//    }
//    
//    func drawRoute(for path: [String: AnyObject], color: UIColor) {
//        let route = path["points"] as! String
//        let mapPath: GMSPath = GMSPath(fromEncodedPath: route)!
//        let routePolyline = GMSPolyline(path: mapPath)
//        routePolyline.strokeColor = color
//        routePolyline.strokeWidth = 5
//        
//        routePolyline.map = map
//    }
//}
//
//extension MapViewController: PendingViewDelegate {
//    
//    func handleCancel() {
//        pendingView.isHidden = true
//        if let requestId = request?.requestId {
//            cancelRequest(for: requestId)
//        }
//    }
//}
//
//extension MapViewController: SearchPlaceBarDelegate {
//    func getMap() -> GMSMapView {
//        return map
//    }
//    
//    func dropPin(location: CLLocationCoordinate2D) {
//        map.addMarker(at: location)
//    }
//    
//    func resultSelected(place: GMSPlace) {
//        map.addMarker(at: place.coordinate)
//        
//    }
//    
//    func drawPath(path: GMSPolyline) {
//        print(path)
//        path.map = map
//    }
//    
//    func getClient() -> GMSPlacesClient {
//        return client
//    }
//}
//
//extension MapViewController: BottomViewDelegate {
//    
//    func handleBottomCancel() {
//        guard let requestId = request?.requestId else {
//            return
//        }
//        
//        cancelRequest(for: requestId)
//    }
//}

import UIKit
import GoogleMaps
import Firebase
import GooglePlaces

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    var backView: UIView!
    var map : GMSMapView!
    var locationManager : CLLocationManager!
    var backTopAnchor: NSLayoutConstraint!
    var backHeightAnchor: NSLayoutConstraint!
    var currentLocation : CLLocationCoordinate2D? {
        get {
            if let location = locationManager.location {
                return location.coordinate
            }
            return nil
        }
    }
    
    var client: GMSPlacesClient = GMSPlacesClient()
    
    var firebaseHandlers: [UInt] = [UInt]()
    
    var request: Request?
    
    var delegate: CenterViewControllerDelegate?
    
    let bottomBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var pendingView: PendingView = {
        let pv = PendingView(frame: self.view.frame)
        pv.delegate = self
        pv.isHidden = true
        return pv
    }()
    
    lazy var buddyUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("BuddyUp!", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleBuddyUp), for: .touchUpInside)
        button.backgroundColor = .blue
        button.isHidden = false
        return button
    }()
    
    lazy var yesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Yes", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.green, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handleYes), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var noButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("No", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handleNo), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var walkrView: WalkrView = {
        let wv = WalkrView()
        wv.isHidden = true
        wv.translatesAutoresizingMaskIntoConstraints = false
        wv.delegate = self
        return wv
    }()
    
    lazy var requesterView: RequesterView = {
        let rv = RequesterView()
        rv.isHidden = true
        rv.translatesAutoresizingMaskIntoConstraints = false
        rv.delegate = self
        return rv
    }()
    
    var bottomBarHeightAnchor: NSLayoutConstraint?
    var bottomState: BottomBarState = .buddyUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocation()
        initMap()
        
        setupMap()
        
        setupNavigationBar()
        
        checkIfSomeoneRequesting()
        
        view.addSubview(pendingView)
        
    }
    
    
    
    func setupMap() {
        guard let location = self.currentLocation else {
            return
        }
        
        self.map.camera = GMSCameraPosition.camera(withTarget: location, zoom: 15)
    }
    
    func setupMapForRequest(request: Request) {
        bottomState = .confirm
        updateBottomBar()
        
        let startLocation = request.location //CLLocationCoordinate2D(latitude: 39.951557 , longitude: -75.193205)
        let endLocation = request.destination //CLLocationCoordinate2D(latitude: 39.953480 , longitude: -75.191414)
        
        self.map.addMarker(at: startLocation)
        self.map.addMarker(at: endLocation)
        
        self.getDirections(from: startLocation, to: endLocation, color: UIColor.green)
        if let location = self.currentLocation {
            self.getDirections(from: location, to: startLocation, color: UIColor.blue)
        }
        
    }
    
    func initLocation() {
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func initMap() {
        map = GMSMapView()
        map.delegate = self
        map.settings.myLocationButton = true
        map.settings.compassButton = true
        map.isMyLocationEnabled = true
        
        self.view.addSubview(map)
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: map,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .top,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: map,
                attribute: .left,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .left,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: map,
                attribute: .right,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .right,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addSubview(bottomBar)
        self.view.addConstraint(
            NSLayoutConstraint(
                item: bottomBar,
                attribute: .left,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .left,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: bottomBar,
                attribute: .right,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .right,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: bottomBar,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .bottom,
                multiplier: 1,
                constant: 0
            )
        )
        
        bottomBarHeightAnchor = bottomBar.heightAnchor.constraint(equalToConstant: 60)
        bottomBarHeightAnchor?.isActive = true
        
        //bottom of map to top of button
        self.view.addConstraint(
            NSLayoutConstraint(
                item: map,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: bottomBar,
                attribute: .top,
                multiplier: 1,
                constant: 0
            )
        )
        
        map.translatesAutoresizingMaskIntoConstraints = false
        
        setupBottomBar()
        
        map.isExclusiveTouch = false
        map.settings.consumesGesturesInView = false
        
        ///###################################
        backView = UIView()
        backView.backgroundColor = .red
        map.addSubview(backView)
        map.bringSubview(toFront: backView)
        //        tableHeightAnchor =
        //            NSLayoutConstraint(
        //                item: tableView,
        //                attribute: .height,
        //                relatedBy: .equal,
        //                toItem: searchBar,
        //                attribute: .height,
        //                multiplier: 0,
        //                constant: 0
        //        )
        
        backTopAnchor = backView.anchor(map.topAnchor, left: map.leftAnchor, bottom: nil, right: map.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)[0]
        backHeightAnchor = backView.heightAnchor.constraint(equalToConstant: 30)
        backHeightAnchor?.isActive = true
        
        let searchView = SearchPlaceBar()
        searchView.delegate = self
        
        
        backView.addSubview(searchView)
        backView.bringSubview(toFront: searchView)
        //self.map.bringSubview(toFront: searchView)
        //v.addSubview(searchController.searchBar)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        _ = searchView.anchor(backView.topAnchor, left: backView.leftAnchor, bottom: backView.bottomAnchor, right: backView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    func setupBottomBar() {
        let bar = bottomBar
        bar.addSubview(noButton)
        bar.addSubview(yesButton)
        
        _ = noButton.anchor(bar.topAnchor, left: bar.leftAnchor, bottom: bar.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        noButton.widthAnchor.constraint(equalTo: bar.widthAnchor, multiplier: 0.5).isActive = true
        
        _ = yesButton.anchor(bar.topAnchor, left: nil, bottom: bar.bottomAnchor, right: bar.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        yesButton.widthAnchor.constraint(equalTo: bar.widthAnchor, multiplier: 0.5).isActive = true
        
        bar.addSubview(buddyUpButton)
        
        buddyUpButton.anchorToTop(bar.topAnchor, left: bar.leftAnchor, bottom: bar.bottomAnchor, right: bar.rightAnchor)
        
        bottomBar.addSubview(walkrView)
        bottomBar.addSubview(requesterView)
        
        walkrView.anchorToTop(bottomBar.topAnchor, left: bottomBar.leftAnchor, bottom: bottomBar.bottomAnchor, right: bottomBar.rightAnchor)
        requesterView.anchorToTop(bottomBar.topAnchor, left: bottomBar.leftAnchor, bottom: bottomBar.bottomAnchor, right: bottomBar.rightAnchor)
    }
    
    func setupNavigationBar() {
        let image = UIImage(named: "Menu")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.itemWith(colorfulImage: image, target: self, action: #selector(handleShow))
        self.title = User.current?.name
        
        print(navigationController == nil)
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let view = UIView()
        view.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        view.backgroundColor = UIColor.black
        return view
    }
    
    func direct(to place: CLLocationCoordinate2D) {
        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            UIApplication.shared.open(
                URL(string: "comgooglemaps://?saddr=&daddr=\(place.latitude),\(place.longitude)&directionsmode=driving")!,
                options: [:],
                completionHandler: { (success) in
                    print(success)
            }
            )
        }
        else {
            print("Can't use comgooglemaps://")
            UIApplication.shared.open(
                URL(string: "https://maps.google.com/?q=@\(place.latitude),\(place.longitude)")!,
                options: [:],
                completionHandler: { (works) in
                    print(works)
            }
            )
        }
    }
    
    //    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
    //        //direct(to: current)
    //        getDirections(from: current, to: currentUser.location)
    //        getDirections(from: currentUser.location, to: currentUser.destination)
    //        return true
    //
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func getDirections(request: Request) {
        getDirections(from: request.location, to: request.destination, color: UIColor.red)
    }
    
    func getDirections(from: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, color: UIColor){
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(from.latitude),\(from.longitude)&destination=\(destination.latitude),\(destination.longitude)&key=AIzaSyBrcUvjEBZsRj63gQltNht6aTIYIrFLrj0&mode=walking")
        let request = URLRequest(url: url!)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    let selectedRoute = (jsonResult["routes"] as! Array<Dictionary<String, AnyObject>>)[0]
                    let overViewPolyLine = selectedRoute["overview_polyline"] as! Dictionary<String, AnyObject>
                    DispatchQueue.main.async {
                        
                        self.drawRoute(for: overViewPolyLine, color: color)
                    }
                }
            }
            catch{
                
                print("Somthing wrong")
            }
        });
        
        // do whatever you need with the task e.g. run
        task.resume()
    }
    
    func drawRoute(for path: [String: AnyObject], color: UIColor) {
        let route = path["points"] as! String
        let mapPath: GMSPath = GMSPath(fromEncodedPath: route)!
        let routePolyline = GMSPolyline(path: mapPath)
        routePolyline.strokeColor = color
        routePolyline.strokeWidth = 5
        
        routePolyline.map = map
    }
}

extension MapViewController: PendingViewDelegate {
    
    func handleCancel() {
        pendingView.isHidden = true
        if let requestId = request?.requestId {
            cancelRequest(for: requestId)
        }
    }
    
}

extension MapViewController: SearchPlaceBarDelegate {
    func getMap() -> GMSMapView {
        return map
    }
    
    func dropPin(location: CLLocationCoordinate2D) {
        map.addMarker(at: location)
    }
    
    func resultSelected(place: GMSPlace) {
        map.addMarker(at: place.coordinate)
        updateSize(for: 30)
        sendRequest(destination: place.coordinate)
    }
    
    func drawPath(path: GMSPolyline) {
        print(path)
        path.map = map
    }
    
    func getClient() -> GMSPlacesClient {
        return client
    }
    
    func updateSize(for size: CGFloat) {
        backHeightAnchor?.constant = size
        animate()
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension MapViewController: BottomViewDelegate {
    
    func handleBottomCancel() {
        guard let requestId = request?.requestId else {
            return
        }
        
        cancelRequest(for: requestId)
    }
}
