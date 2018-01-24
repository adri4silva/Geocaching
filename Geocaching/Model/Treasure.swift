//
//  File.swift
//  Geocaching
//
//  Created by Adrián Silva on 23/1/18.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation
import MapKit


class Treasure: NSObject, MKAnnotation {

    var title: String?
    var subtitle: String?
    var info: String?
    var coordinate: CLLocationCoordinate2D
    var isCatched: Bool = false
    var persons: [Person]?

    init(title: String, subtitle: String, info: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.info = info
        self.coordinate = coordinate
    }
    
}
