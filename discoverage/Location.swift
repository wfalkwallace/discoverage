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
    var locationManager : CLLocationManager

    override init () {
        println("locations constructor")
        self.locationManager = CLLocationManager()
        super.init()
    }
    
    class var sharedInstance: Location {
        struct Static {
            static let instance = Location ()
        }
        return Static.instance
    }

    func startUpdatingLocation() {
        println("start updating location")

        //self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.distanceFilter = 10.0
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Failed to update location : \(error)")
        //self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("auth changed")
        
        switch CLLocationManager.authorizationStatus() {
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                println("authorized to use location!")
                //send notification
            case .NotDetermined:
                println("not determined")
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.startUpdatingLocation()
            case .AuthorizedWhenInUse, .Restricted, .Denied:
                println("denied")
                let alertController = UIAlertController(
                title: "Background Location Access Disabled", message: "In order to be notified about adorable kittens near you, please open this app's settings and set location access to 'Always'.", preferredStyle: .Alert)
            
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

    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        
        //check if current user exists and do stuff, if no user, stop updating location
        if let user = User.currentUser {
            println("current user exists, doing location stuff")
            var currentLocation = locations.last as! CLLocation
            
            //claim nearby bananas and monsters the first time the location changes and every 60 seconds thereafter
            if let userLocation = user.location {
                let interval = currentLocation.timestamp.timeIntervalSinceDate(user.location!.timestamp)
                if interval >= 60.0 {
                    user.location = currentLocation
                    user.claimBananasAndAnimals()
                    NSNotificationCenter.defaultCenter().postNotificationName("updateViews", object: nil)

                }
                println(interval)
            } else {
                user.location = currentLocation
                NSNotificationCenter.defaultCenter().postNotificationName("updateViews", object: nil)
                user.claimBananasAndAnimals()
            }
            
        } else {
            stopUpdatingLocation()
        }
        
        //lastTenLocato
        
//        NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
//
//        
//        let geoPoint = PFGeoPoint(location: locations.last as? CLLocation)
//        
//        var aQuery = PFQuery(className: "Animal")
//        aQuery.whereKey("location", nearGeoPoint: geoPoint, withinMiles: 0.1)
//        aQuery.limit = 1
//        
//        if let animal = aQuery.findObjects()?[0] as? PFObject {
//            let animal = Animal(object: animal)
//            animal.save() {(success: Bool, error: NSError?) -> Void in println("saved animal!")}
//        }
//
//        var bQuery = PFQuery(className: "BananaTree")
//        bQuery.whereKey("location", nearGeoPoint: geoPoint, withinMiles: 0.1)
//        bQuery.limit = 10
//        
//        if let bananaTrees = bQuery.findObjects() {
//            for bananaTree in bananaTrees {
//                User.currentUser?.bananaCount += 1
//                let bananaPick = BananaPick(bananaTree: BananaTree(object: bananaTree as! PFObject), timestamp: NSDate())
//                bananaPick.save() {(success: Bool, error: NSError?) -> Void in println("saved bananaPick!")}
//            }
//        }
    }
}
