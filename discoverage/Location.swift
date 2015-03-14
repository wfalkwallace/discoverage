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
        
        var aQuery = PFQuery(className: "Animal")
        aQuery.whereKey("location", nearGeoPoint: geoPoint, withinMiles: 0.1)
        aQuery.limit = 1
        
        if let animal = aQuery.findObjects()?[0] as? PFObject {
            let animal = Animal(object: animal)
            animal.owner = User.currentUser
            animal.save({ (error: NSError) })
        }

        var bQuery = PFQuery(className: "BananaTree")
        bQuery.whereKey("location", nearGeoPoint: geoPoint, withinMiles: 0.1)
        bQuery.limit = 10
        
        if let bananaTrees = bQuery.findObjects() {
            for bananaTree in bananaTrees {
                User.currentUser?.bananaCount += 1
                User.currentUser?.bananaPicks.append(BananaPick(bananaTree: BananaTree(object: bananaTree as! PFObject), timestamp: NSDate()))
            }
        }
    }
}
