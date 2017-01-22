//
//  MapViewController.swift
//  Penn
//
//  Created by Jack O'Donnell on 1/20/17.
//  Copyright © 2017 Jack O'Donnell. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController2: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate, UITableViewDelegate, GMSAutocompleteTableDataSourceDelegate {
    //var v: UIView!
    var map : GMSMapView!
    var locationManager : CLLocationManager!
    var searchBar: UISearchBar!
    var tableDataSource: GMSAutocompleteTableDataSource?
    //var searchController: UISearchController!
    var tableView: UITableView!
    var currentLocation : CLLocationCoordinate2D? {
        get {
            if let location = locationManager.location {
                return location.coordinate
            }
            return nil
        }
    }
    
    var request: Request? {
        didSet {

        }
    }
    
    
    
    var someoneRequesting: Bool = false
    
    func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        
    }
    
    func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let text = searchBar.text {
            if text != "" {
                tableDataSource?.sourceTextHasChanged(text)
                expandTableHeightAnchor(expand: true)
            }
            else {
                expandTableHeightAnchor(expand: false)
            }
        }
        else {
            //animate
            expandTableHeightAnchor(expand: false)

        }
        tableView.reloadData()
        
        
        
    }
    
    var delegate: CenterViewControllerDelegate? {
        didSet{
            print("set")
        }
    }
    
    
    
    let bottomBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var buddyUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("BuddyUp!", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleBuddyUp), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()
    
    lazy var yesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Yes", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.green, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handleYes), for: .touchUpInside)
        return button
    }()
    
    lazy var noButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("No", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handleNo), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocation()
        initMap()

        
        
        someoneRequesting = true
        
        setupNavigationBar()
        
        checkIfSomeoneRequesting()
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        searchBar.resignFirstResponder()
        expandTableHeightAnchor(expand: false)
    }
    
    func checkIfSomeoneRequesting() {
        if someoneRequesting {
            setupBottomBar(bar: bottomBar)
            
            let startLocation = CLLocationCoordinate2D(latitude: 39.951557 , longitude: -75.193205)
            let endLocation = CLLocationCoordinate2D(latitude: 39.953480 , longitude: -75.191414)
        
            self.map.addMarker(at: startLocation)
            self.map.addMarker(at: endLocation)
            
            self.getDirections(from: startLocation, to: endLocation, color: UIColor.green)
            
            if let location = self.currentLocation {

                let when = DispatchTime.now() + 0.2
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.getDirections(from: location, to: startLocation, color: UIColor.blue)
                    self.map.camera = GMSCameraPosition.camera(withTarget: location, zoom: 15)
                }
                self.getDirections(from: location, to: startLocation, color: UIColor.blue)
            }
        }
    }
    
    func initLocation() {
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
    }
    
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        // TODO: Handle the error.
        print("Error: \(error)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        expandTableHeightAnchor(expand: false)
    }
    
        
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        let id = prediction.placeID
        let client = GMSPlacesClient()
        client.lookUpPlaceID(id!) {place,error in
            if let error = error {
                print(error)
            }
            else {
                guard let coord = place?.coordinate else {
                    return
                }
                self.map.addMarker(at: coord)
                self.searchBar.text = place?.name
                self.searchBar.resignFirstResponder()
                self.expandTableHeightAnchor(expand: false)
                
            }
        }
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        expandTableHeightAnchor(expand: true)
        return true
    }
    
    var tableHeightAnchor: NSLayoutConstraint?
    
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
                constant: 1
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
                constant: 1
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
                constant: 1
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
                constant: 1
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
                constant: 1
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
                constant: 1
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: bottomBar,
                attribute: .height,
                relatedBy: .equal,
                toItem: self.view,
                attribute: .height,
                multiplier: 1/10,
                constant: 1
            )
        )
        
        //bottom of map to top of button
        self.view.addConstraint(
            NSLayoutConstraint(
                item: map,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: bottomBar,
                attribute: .top,
                multiplier: 1,
                constant: 1
            )
        )
        
        map.translatesAutoresizingMaskIntoConstraints = false
        
//        v = UIView()
        searchBar = UISearchBar()
        searchBar.delegate = self
        //v.backgroundColor = UIColor.brown
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        
        //searchController.hidesNavigationBarDuringPresentation = false
        // searchController.dimsBackgroundDuringPresentation = false
        //searchController.obscuresBackgroundDuringPresentation = false
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource?.delegate = self
        
        //searchController.searchResultsUpdater = self
        //searchController.delegate = self
        searchBar.delegate = self
        
        self.map.addSubview(searchBar)
        self.map.bringSubview(toFront: searchBar)
        //v.addSubview(searchController.searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        map.addConstraint(
            NSLayoutConstraint(
                item: searchBar,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: map,
                attribute: .centerX,
                multiplier: 1,
                constant: 1
            )
        )
        map.addConstraint(
            NSLayoutConstraint(
                item: searchBar,
                attribute: .width,
                relatedBy: .equal,
                toItem: map,
                attribute: .width,
                multiplier: 7/8,
                constant: 1
            )
        )
        map.addConstraint(
            NSLayoutConstraint(
                item: searchBar,
                attribute: .height,
                relatedBy: .equal,
                toItem: map,
                attribute: .height,
                multiplier: 1/10,
                constant: 1
            )
        )
        map.addConstraint(
            NSLayoutConstraint(
                item: searchBar,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: map,
                attribute: .centerY,
                multiplier: 1/3,
                constant: 1
            )
        )
        
        //TableView
        tableView = UITableView()
        tableView.delegate = tableDataSource
        tableView.dataSource = tableDataSource
        
        map.addSubview(tableView)
        map.bringSubview(toFront: tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        map.addConstraint(
            NSLayoutConstraint(
                item: tableView,
                attribute: .width,
                relatedBy: .equal,
                toItem: searchBar,
                attribute: .width,
                multiplier: 1,
                constant: 1
            )
        )
        
//        tableHeightAnchor = NSLayoutConstraint(
//            item: tableView,
//            attribute: .height,
//            relatedBy: .equal,
//            toItem: searchBar,
//            attribute: .height,
//            multiplier: 3,
//            constant: 1
//        )
        
        tableHeightAnchor = tableView.heightAnchor.constraint(equalToConstant: 0)
        tableHeightAnchor?.isActive = true
        
//        map.addConstraint(
//            tableHeightAnchor
//        )
        
        map.addConstraint(
            NSLayoutConstraint(
                item: tableView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: searchBar,
                attribute: .centerX,
                multiplier: 1,
                constant: 1
            )
        )
        
        map.addConstraint(
            NSLayoutConstraint(
                item: tableView,
                attribute: .top,
                relatedBy: .equal,
                toItem: searchBar,
                attribute: .bottom,
                multiplier: 1,
                constant: 15
            )
        )
        
        setupBottomBar(bar: bottomBar)
        //map.isExclusiveTouch = false
        map.settings.consumesGesturesInView = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func setupBottomBar(bar: UIView) {
        buddyUpButton.removeFromSuperview()
        noButton.removeFromSuperview()
        yesButton.removeFromSuperview()
        
        if someoneRequesting {
            
            bar.addSubview(noButton)
            bar.addSubview(yesButton)
            
            _ = noButton.anchor(bar.topAnchor, left: bar.leftAnchor, bottom: bar.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            noButton.widthAnchor.constraint(equalTo: bar.widthAnchor, multiplier: 0.5).isActive = true
            
            _ = yesButton.anchor(bar.topAnchor, left: nil, bottom: bar.bottomAnchor, right: bar.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            yesButton.widthAnchor.constraint(equalTo: bar.widthAnchor, multiplier: 0.5).isActive = true
            
        } else {
            bar.addSubview(buddyUpButton)
            
            buddyUpButton.anchorToTop(bar.topAnchor, left: bar.leftAnchor, bottom: bar.bottomAnchor, right: bar.rightAnchor)
        }

    }
    
    func setupNavigationBar() {
        let image = UIImage(named: "Menu")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.itemWith(colorfulImage: image, target: self, action: #selector(handleShow))
        self.title = User.current?.name
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let view = UIView()
        view.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        view.backgroundColor = UIColor.black
        return view
    }
    
    
    
    func setupNavigation() {
        //self.title = User.current?.name
        
        self.navigationItem.titleView = {
            let view = UIView()
            view.bounds = CGRect(x: 0, y: 5, width: 35, height: 35)
            view.layer.cornerRadius = view.bounds.height/2
            view.backgroundColor = UIColor.cyan
            return view
        }()
        
        navigationItem.prompt = User.current?.name
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
    
    func expandTableHeightAnchor(expand: Bool) {
        tableHeightAnchor?.constant = expand ? 180 : 0
        
        animate()
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.2, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
