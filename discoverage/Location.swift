//
//  Location.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate  {
   override init () {
        switch CLLocationManager.authorizationStatus() {
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                println("authorized!")
            case .NotDetermined:
                var locManager = CLLocationManager()
                locManager.requestAlwaysAuthorization()
            case .AuthorizedWhenInUse, .Restricted, .Denied:
                let alertController = UIAlertController(
                    title: "Background Location Access Disabled",
                    message: "In order to be notified about adorable kittens near you, please open this app's settings and set location access to 'Always'.",
                    preferredStyle: .Alert)

                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                alertController.addAction(cancelAction)

                let openAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
                    if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                        UIApplication.sharedApplication().openURL(url)
                    }
                }

                alertController.addAction(openAction)
        }
    }
    
    class var sharedInstance: Location {
        struct Static {
            static let instance = Location ()
        }
        
        return Static.instance
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println(locations)
        println(locations.last)
        
        let geoPoint = PFGeoPoint(location: locations.last as? CLLocation)
        var query = PFQuery(className: "BananaTree")
        query.whereKey("location", nearGeoPoint: geoPoint, withinMiles: 0.1)
        query.limit = 10
        
        if let bananaTrees = query.findObjects() {
            for bananaTree in bananaTrees {
                // Add to user's banana stash
            }
        }
    }
}
