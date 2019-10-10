//
//  MainPageViewController.swift
//  ZomatoRappi
//
//  Created by Usuario1 on 10/9/19.
//  Copyright © 2019 danielBeltran. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainPageViewController: UIViewController {

    let locationManager = CLLocationManager()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var restaurantTableView: UITableView!
    @IBOutlet weak var restaurantCell: UITableViewCell!
    
    var viewModel = MainPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        restaurantTableView.delegate = self
        getCoordinates()
    }
    
    func getCoordinates(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func drawCoordinatesOnMapView(with coordinates: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        mapView.showsBuildings = true
    }
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRestautants().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        restaurantCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "MyCell")
        
        restaurantCell.textLabel!.text = "\(viewModel.getRestautants()[indexPath.row].name)"
        restaurantCell.detailTextLabel?.text = " latitude:\(viewModel.getRestautants()[indexPath.row].latitude)"
        restaurantCell.accessoryType = .detailDisclosureButton
        return restaurantCell
    }
    
    
}

extension MainPageViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        drawCoordinatesOnMapView(with: locValue)
    }
}
