# Geocaching Tutorial

This page explains how to build a Geocaching Social App using Swfit 4 & MapKit

## Prerequisites

This is an intermediate-level tutorial, so if you don't have the neccesary knowledge, just try to level up your Swift game!

### Tools

For this app I used the following tools

* Xcode 9.2
* MapKit
* Firebase
* QRCodeReader Pod

If you want to learn how to use CocoaPods click [this](https://guides.cocoapods.org/using/getting-started.html) link, it will be needed to the next step

### Installing Dependencies

In Podfile you must specify the following pods

```
pod 'QRCodeReader.swift'
pod 'Firebase/Auth'
pod 'Firebase/Database'
```

Then go to terminal and inside the proyect folder use:

```
pod install
```

Now you just have to close your project and run the new .xcworkspace file


## MapKit Tutorial

Explaining the MapKit basics

### Current Location

How to locate the user using `CLLocationManager`

* When locating an user you must ask for permission on the Info.plist file of the project, then on code you must check that you have permission to locate that user. The following function checks if the user authorized the permissions:

```Swift
func startReceivingLocationChanges() {
    if (CLLocationManager.locationServicesEnabled()) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}
```

* We can handle the different options if the user didn't authorize the location permission:

```Swift
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
```

* There is a function on the Delegate Class called `didUpdateLocations` that allows us to do something when the user changes the location. In our project it's the following piece of code:

```Swift
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    location = locations.last!
    if let currentLocation = location {
        centerMapOnLocation(location: currentLocation)
        let p1 = currentLocation
        let p2 = CLLocation(latitude: treasure.coordinate.latitude, longitude: treasure.coordinate.longitude)

        distance = p1.distance(from: p2)
    }
}
```

It changes the Map region every time the user changes location and calculates the distance between the user and the selected treasure

```Swift

func centerMapOn(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
}
```


### Making treasure annotations on MapKit

Now that we have the user current location, we must perform some actions to see annotations on the mapView

* First of all we configure our mapView in `viewDidLoad` method of our Class

```Swift
override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
    mapView.showsUserLocation = true
    mapView.addAnnotation(treasure)
    startReceivingLocationChanges()
}
```

* In this proyect we made a custom class that allowed us to make custom annotation objects

```Swift
class Treasure: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var info: String?
    var coordinate: CLLocationCoordinate2D
    var isCatched: Bool = false
    var persons: [Person]?
}
```

The MKAnnotation inheritance class is the key point to make custom annotations

In this proyect we wanted the annotations to perform a segue to another ViewController so the next piece of code show that process

```Swift
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
```

## Demo

![Gif](http://www.giphy.com/gifs/l4pTncolcbdAlL9Ac)

## Authors

* **Adrian Silva** - [Web](https://adri4silva.github.io)
