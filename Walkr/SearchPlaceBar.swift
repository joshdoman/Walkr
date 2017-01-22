//
//  SearchBar.swift
//  Walkr
//
//  Created by Jack O'Donnell on 1/21/17.
//  Copyright © 2017 Josh Doman. All rights reserved.
//

//import UIKit
//import GoogleMaps
//import GooglePlaces
//
//protocol SearchPlaceBarDelegate {
//    func dropPin(location: CLLocationCoordinate2D)
//    func getMap() -> GMSMapView
//    func getClient() -> GMSPlacesClient
//    func resultSelected(place: GMSPlace)
//    func drawPath(path: GMSPolyline)
//}
//
//class SearchPlaceBar: UIView, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
//    
//    var list: [GMSPlace] = []
//    var view : UIView = UIView()
//    var searchBar: UISearchBar = UISearchBar()
//    var tableView: UITableView = UITableView()
//    var tableHeightAnchor: NSLayoutConstraint?
//    
//    var delegate: SearchPlaceBarDelegate?
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        initSearchBar()
//        initTable()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func initSearchBar() {
//        searchBar.delegate = self
//        addSubview(searchBar)
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//
//        addConstraint(
//            NSLayoutConstraint(
//                item: searchBar,
//                attribute: .width,
//                relatedBy: .equal,
//                toItem: self,
//                attribute: .width,
//                multiplier: 1,
//                constant: 1
//            )
//        )
//        addConstraint(
//            NSLayoutConstraint(
//                item: searchBar,
//                attribute: .top,
//                relatedBy: .equal,
//                toItem: self,
//                attribute: .top,
//                multiplier: 1,
//                constant: 1
//            )
//        )
//        addConstraint(
//            NSLayoutConstraint(
//                item: searchBar,
//                attribute: .height,
//                relatedBy: .equal,
//                toItem: searchBar,
//                attribute: .height,
//                multiplier: 1,
//                constant: 50
//            )
//        )
//    }
//    
//    func initTable() {
//        //TableView
//        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: "placeCell")
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        addSubview(tableView)
//        
//        //Constraints
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        
//        tableHeightAnchor =
//        NSLayoutConstraint(
//            item: tableView,
//            attribute: .height,
//            relatedBy: .equal,
//            toItem: searchBar,
//            attribute: .height,
//            multiplier: 1,
//            constant: 1
//        )
//        
//        tableHeightAnchor?.isActive = true
//
//        addConstraint(
//            NSLayoutConstraint(
//                item: tableView,
//                attribute: .width,
//                relatedBy: .equal,
//                toItem: searchBar,
//                attribute: .width,
//                multiplier: 1,
//                constant: 1
//            )
//        )
//        addConstraint(
//            NSLayoutConstraint(
//                item: tableView,
//                attribute: .centerX,
//                relatedBy: .equal,
//                toItem: searchBar,
//                attribute: .centerX,
//                multiplier: 1,
//                constant: 1
//            )
//        )
//        addConstraint(
//            NSLayoutConstraint(
//                item: tableView,
//                attribute: .top,
//                relatedBy: .equal,
//                toItem: searchBar,
//                attribute: .bottom,
//                multiplier: 1,
//                constant: 15
//            )
//        )
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceTableViewCell
//        cell.place = list[indexPath.row]
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell : PlaceTableViewCell = tableView.cellForRow(at: indexPath) as! PlaceTableViewCell
//        
//        //self.map.addMarker(at: cell.place!.coordinate)
//        //getDirections(from: currentLocation!, to: cell.place!.coordinate, color: UIColor.green)
//        self.searchBar.text = cell.place!.name
//        self.searchBar.resignFirstResponder()
//        self.expandTableHeightAnchor(expand: false)
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.count
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 55
//    }
//    
//    func animate() {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.2, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
//    }
//    
//    func expandTableHeightAnchor(expand: Bool) {
//        tableHeightAnchor?.constant = expand ? 180 : 0
//        animate()
//    }
//    
//    
//    //Search bar
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if let text = searchBar.text {
//            if text != "" {
//                autocomplete(text) {
//                    self.tableView.reloadData()
//                    self.expandTableHeightAnchor(expand: true)
//                }
//            }
//            else {
//                expandTableHeightAnchor(expand: false)
//            }
//        }
//        else {
//            //animate
//            expandTableHeightAnchor(expand: false)
//        }
//        tableView.reloadData()
//    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! PlaceTableViewCell
//        
//        searchBar.text = cell.place?.name
//        searchBar.resignFirstResponder()
//        expandTableHeightAnchor(expand: false)
//        getDirections(from: (delegate?.getMap().myLocation?.coordinate)!, to: (cell.place?.coordinate)!, color: UIColor.red)
//        delegate?.resultSelected(place: cell.place!)
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//    }
//    
//    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        expandTableHeightAnchor(expand: true)
//        return true
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
//        delegate?.drawPath(path: routePolyline)
//    }
//
//    
//    func autocomplete(_ search: String, complete: @escaping () -> ()) {
//        list = []
//        if let map = delegate?.getMap(), let client = delegate?.getClient() {
//            let visibleRegion = map.projection.visibleRegion()
//            let bounds = GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.nearRight)
//            
//            let filter = GMSAutocompleteFilter()
//            filter.type = .establishment
//            client.autocompleteQuery(search, bounds: bounds, filter: filter, callback: {
//                (results, error) -> Void in
//                guard error == nil else {
//                    print("Autocomplete error \(error)")
//                    return
//                }
//                if let results = results {
//                    for prediction in results {
//                        guard let id = prediction.placeID else {
//                            return
//                        }
//                        
//                        client.lookUpPlaceID(id) {place,error in
//                            if let error = error {
//                                print(error)
//                            }
//                            else {
//                                guard let place = place else {
//                                    return
//                                }
//                                
//                                self.list.append(place)
//                                complete()
//                            }
//                        }
//                    }
//                }
//            })
//        }
//    }
//
//    
//}

import UIKit
import GoogleMaps
import GooglePlaces

protocol SearchPlaceBarDelegate {
    func dropPin(location: CLLocationCoordinate2D)
    func getMap() -> GMSMapView
    func getClient() -> GMSPlacesClient
    func resultSelected(place: GMSPlace)
    func drawPath(path: GMSPolyline)
    func updateSize(for size: CGFloat)
}

class SearchPlaceBar: UIView, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var list: [GMSPlace] = []
    var view : UIView = UIView()
    var searchBar: UISearchBar = UISearchBar()
    var tableView: UITableView = UITableView()
    var tableHeightAnchor: NSLayoutConstraint?
    
    var delegate: SearchPlaceBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSearchBar()
        initTable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSearchBar() {
        searchBar.delegate = self
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(
            NSLayoutConstraint(
                item: searchBar,
                attribute: .width,
                relatedBy: .equal,
                toItem: self,
                attribute: .width,
                multiplier: 1,
                constant: 0
            )
        )
        addConstraint(
            NSLayoutConstraint(
                item: searchBar,
                attribute: .top,
                relatedBy: .equal,
                toItem: self,
                attribute: .top,
                multiplier: 1,
                constant: 0
            )
        )
        addConstraint(
            NSLayoutConstraint(
                item: searchBar,
                attribute: .height,
                relatedBy: .equal,
                toItem: searchBar,
                attribute: .height,
                multiplier: 1,
                constant: 50
            )
        )
    }
    
    func initTable() {
        //TableView
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: "placeCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubview(tableView)
        
        //Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableHeightAnchor =
            NSLayoutConstraint(
                item: tableView,
                attribute: .height,
                relatedBy: .equal,
                toItem: searchBar,
                attribute: .height,
                multiplier: 0,
                constant: 0
        )
        
        tableHeightAnchor?.isActive = true
        
        addConstraint(
            NSLayoutConstraint(
                item: tableView,
                attribute: .width,
                relatedBy: .equal,
                toItem: searchBar,
                attribute: .width,
                multiplier: 1,
                constant: 0
            )
        )
        addConstraint(
            NSLayoutConstraint(
                item: tableView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: searchBar,
                attribute: .centerX,
                multiplier: 1,
                constant: 0
            )
        )
        addConstraint(
            NSLayoutConstraint(
                item: tableView,
                attribute: .top,
                relatedBy: .equal,
                toItem: searchBar,
                attribute: .bottom,
                multiplier: 1,
                constant: 0
            )
        )
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceTableViewCell
        cell.place = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : PlaceTableViewCell = tableView.cellForRow(at: indexPath) as! PlaceTableViewCell
        
        //self.map.addMarker(at: cell.place!.coordinate)
        //getDirections(from: currentLocation!, to: cell.place!.coordinate, color: UIColor.green)
        getDirections(from: (delegate?.getMap().myLocation?.coordinate)!, to: (cell.place?.coordinate)!, color: UIColor.red)
        delegate?.resultSelected(place: cell.place!)
        self.searchBar.text = cell.place!.name
        self.searchBar.resignFirstResponder()
        self.expandTableHeightAnchor(expand: false)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.2, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func expandTableHeightAnchor(expand: Bool) {
        tableHeightAnchor?.constant = expand ? height() : 0
        animate()
    }
    
    func height() -> CGFloat {
        let rows = list.count
        if rows >= 5 {
            return 4 * 55
        }
        else {
            return CGFloat(rows * 55)
        }
    }
    
    
    //Search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            if text != "" {
                autocomplete(text) { result in
                    self.list = result
                    self.tableView.reloadData()
                    self.expandTableHeightAnchor(expand: true)
                    
                    self.delegate?.updateSize(for: self.height() + 30)
                }
            }
            else {
                expandTableHeightAnchor(expand: false)
                self.delegate?.updateSize(for: self.height() + 30)
            }
        }
        else {
            //animate
            expandTableHeightAnchor(expand: false)
            self.delegate?.updateSize(for: self.height() + 30)
        }
        self.delegate?.updateSize(for: self.height() + 30)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! PlaceTableViewCell
        
        searchBar.text = cell.place?.name
        searchBar.resignFirstResponder()
        expandTableHeightAnchor(expand: false)
        getDirections(from: (delegate?.getMap().myLocation?.coordinate)!, to: (cell.place?.coordinate)!, color: UIColor.red)
        delegate?.resultSelected(place: cell.place!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        expandTableHeightAnchor(expand: true)
        return true
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
        
        delegate?.drawPath(path: routePolyline)
    }
    
    
    func autocomplete(_ search: String, complete: @escaping ([GMSPlace]) -> ()) {
        var tempList : [GMSPlace] = []
        if let map = delegate?.getMap(), let client = delegate?.getClient() {
            let visibleRegion = map.projection.visibleRegion()
            let bounds = GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.nearRight)
            
            let filter = GMSAutocompleteFilter()
            filter.type = .establishment
            client.autocompleteQuery(search, bounds: bounds, filter: filter, callback: {
                (results, error) -> Void in
                guard error == nil else {
                    print("Autocomplete error \(error)")
                    return
                }
                if let results = results {
                    var count = 0 {
                        didSet {
                            if count == results.count {
                                complete(tempList)
                            }
                        }
                    }
                    for prediction in results {
                        guard let id = prediction.placeID else {
                            return
                        }
                        
                        client.lookUpPlaceID(id) {place,error in
                            if let error = error {
                                print(error)
                            }
                            else {
                                guard let place = place else {
                                    return
                                }
                                
                                tempList.append(place)
                                count += 1
                            }
                        }
                    }
                }
            })
        }
    }
    
    
}
