//
//  LocationManager.swift
//  ONUS
//
//  Created by Devansh Vyas on 22/05/19.
//  Copyright © 2019 Solution Analysts. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationDelegate {
    func updatedLocation(latitude: String, longitude: String)
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    let manager = CLLocationManager()
    var latitude: String?
    var longitude: String?
    var delegate: LocationDelegate?
    
    func checkLocation() {
        manager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
            manager.startUpdatingLocation()
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let lat = locations.last?.coordinate.latitude.description, let long = locations.last?.coordinate.longitude.description {
            latitude = lat
            longitude = long
            delegate?.updatedLocation(latitude: lat, longitude: long)
        } else {
            manager.startUpdatingLocation()
        }
    }
}
