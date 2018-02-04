# Geocaching Tutorial

This page explains how to build a Geocaching Social App using Swfit 4 & MapKit

## Prerequisites

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

* It changes the Map region every time the user changes location

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

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc
