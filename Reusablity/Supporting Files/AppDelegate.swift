//
//  AppDelegate.swift
//  Reusablity
//
//  Created by Devansh Vyas on 16/05/19.
//  Copyright © 2019 Devansh Vyas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let locationManager = LocationManager.shared
        locationManager.checkLocation()
        locationManager.delegate = self
        return true
    }

}

extension AppDelegate: LocationDelegate {
    func updatedLocation(latitude: String, longitude: String) {
        print("latitude--",latitude)
        print("longitude--",longitude)
    }
}
