//
//  MapViewController.swift
//  Penn
//
//  Created by Jack O'Donnell on 1/20/17.
//  Copyright © 2017 Jack O'Donnell. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    var map : GMSMapView!
    var locationManager : CLLocationManager!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocation()
        initMap()

        setupNavigation()
        
        let when = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: when) {
            let startLocation = CLLocationCoordinate2D(latitude: 39.951557 , longitude: -75.193205)
            let endLocation = CLLocationCoordinate2D(latitude: 39.953480 , longitude: -75.191414)

            self.map.addMarker(at: startLocation)
            self.map.addMarker(at: endLocation)
            
            if let location = self.currentLocation {
                self.map.addMarker(at: location)
                self.getDirections(from: location, to: startLocation, color: UIColor.blue)
            }
            
            self.getDirections(from: startLocation, to: endLocation, color: UIColor.green)
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
        
//        self.view.addConstraint(
//            NSLayoutConstraint(
//                item: map,
//                attribute: .bottom,
//                relatedBy: .equal,
//                toItem: self.view,
//                attribute: .bottom,
//                multiplier: 1,
//                constant: 1
//            )
//        )
        
        let v = UIView()
        self.view.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(
            NSLayoutConstraint(
                item: v,
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
                item: v,
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
                item: v,
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
                item: v,
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
                toItem: v,
                attribute: .top,
                multiplier: 1,
                constant: 1
            )
        )
        
        v.backgroundColor = UIColor.red
        
        map.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let view = UIView()
        view.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        view.backgroundColor = UIColor.black
        return view
    }
    
    func setupNavigation() {
        self.title = User.current?.name
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
                    print(selectedRoute)
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
        print(path)
        let route = path["points"] as! String
        let mapPath: GMSPath = GMSPath(fromEncodedPath: route)!
        let routePolyline = GMSPolyline(path: mapPath)
        routePolyline.strokeColor = color
        routePolyline.strokeWidth = 5
        
        routePolyline.map = map
    }
}
