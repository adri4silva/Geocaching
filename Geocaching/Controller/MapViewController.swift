//
//  ViewController.swift
//  Geocaching
//
//  Created by Adrián Silva on 22/1/18.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!


    let locationManager = CLLocationManager()
    var location: CLLocation?
    let regionRadius: CLLocationDistance = 1000
    let treasure = Treasure(title: "Apple Infinite Loop",
                                      subtitle: "Apple",
                                      info: "Un tesoro en Cupertino. Su historia es increible.",
                                      coordinate: CLLocationCoordinate2D(latitude: 42.223832, longitude: -8.673438))
    // CLLocationCoordinate2D(latitude: 37.332350, longitude: -122.031999)
    // CLLocationCoordinate2D(latitude: 42.223832, longitude: -8.673438)
    var distance: CLLocationDistance?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.addAnnotation(treasure)
        startReceivingLocationChanges()
    }

}

extension MapViewController: MKMapViewDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTreasureDetails" {
            let treasureInfoViewController = segue.destination as! TreasureInfoViewController
            treasureInfoViewController.treasure = treasure
            treasureInfoViewController.distance = distance
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.performSegue(withIdentifier: "goToTreasureDetails", sender: self)
    }

}

extension MapViewController: CLLocationManagerDelegate {

    func startReceivingLocationChanges() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }

    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last!
        if let currentLocation = location {
            //print("Location: \(currentLocation)")
            centerMapOnLocation(location: currentLocation)
            let p1 = currentLocation
            let p2 = CLLocation(latitude: treasure.coordinate.latitude, longitude: treasure.coordinate.longitude)

            distance = p1.distance(from: p2)
        }
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }

    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }

}

