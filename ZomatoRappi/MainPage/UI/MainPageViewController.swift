//
//  MainPageViewController.swift
//  ZomatoRappi
//
//  Created by Usuario1 on 10/9/19.
//  Copyright © 2019 danielBeltran. All rights reserved.
//

import UIKit
//import MapKit
//import CoreLocation

class MainPageViewController: UIViewController {

//    let locationManager = CLLocationManager()
    
    var viewModel = MainPageViewModel(apiClient: APIClient())

    @IBOutlet weak var categoriesTableView: UITableView!
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        self.categoriesTableView.register(TableViewCell.self, forCellReuseIdentifier: "categoryCell")
//        getCoordinates()
        
        viewModel.getCategories { (categories) in
            categories.forEach({ (category) in
                self.categories.append(category.categories)
            })
            
            self.categoriesTableView.reloadData()
        }
    }
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.categoryName.text = categories[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }

}




//    func getCoordinates(){
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.requestAlwaysAuthorization()
//            locationManager.requestWhenInUseAuthorization()
//            locationManager.startUpdatingLocation()
//        }
//    }
//
//    func drawCoordinatesOnMapView(with coordinates: CLLocationCoordinate2D) {
//        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        let region = MKCoordinateRegion(center: coordinates, span: span)
//
//        mapView.setRegion(region, animated: true)
//        mapView.showsUserLocation = true
//        mapView.showsBuildings = true
//    }
//}

//extension MainPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 20
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath)
//        cell.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
//        return cell
//    }
//
//}

//extension MainPageViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        drawCoordinatesOnMapView(with: locValue)
//    }
//}
