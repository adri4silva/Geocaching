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
    let regionRadius: CLLocationDistance = 1000




    /*        treasure.latitude = 37.332350
     treasure.longitude = -122.031999
     treasure.name = "Apple Infinite Loop"
     treasure.info = "Un tesoro en Cupertino. Su historia es increible."*/

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self

        let userLocation = mapView.userLocation
        if let location = userLocation.location {
            centerMapOnLocation(location: location)
        }
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

extension MapViewController: MKMapViewDelegate {

}

extension MapViewController: CLLocationManagerDelegate {


}

