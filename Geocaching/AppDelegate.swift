//
//  AppDelegate.swift
//  Geocaching
//
//  Created by Adrián Silva on 22/1/18.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()

        

        return true
    }


}

