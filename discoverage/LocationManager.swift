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
import Alamofire

let CACHE_REGION_UPDATE_INTERVAL = 60.0
let CACHE_REGION_RADIUS = 1000.0
let CAPTURE_RADIUS = 50.0

protocol LocationManagerDelegate {
    func locationManager(locationManagerDelegate: LocationManager, didCaptureBananas bananaPicks: [BananaPick], didCaptureAnimals animals: [Animal])
}

class LocationManager: NSObject, CLLocationManagerDelegate  {
    var locationManager : CLLocationManager
    var animalsInRegion = [Animal]()
    var bananaTreesInRegion = [BananaTree]()
    
    var delegate: LocationManagerDelegate?

    override init () {
        self.locationManager = CLLocationManager()
        super.init()
    }
    
    class var sharedInstance: LocationManager {
        struct Static {
            static let instance = LocationManager()
        }
        return Static.instance
    }

    func startUpdatingLocation() {

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
        //self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch CLLocationManager.authorizationStatus() {
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                println("authorized to use location!")
                //send notification
            case .NotDetermined:
                println("not determined")
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.startUpdatingLocation()
            case .Restricted, .Denied:
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
        var currentLocation = locations.last as! CLLocation

        //check if current user exists and do stuff, if no user, stop updating location
        if let user = User.currentUser {
            //println("current user exists, doing location stuff")
            var timeSinceLastUpdate = 0.0
            //claim nearby bananas and monsters the first time the location changes and every 60 seconds thereafter
            if let lastLocation = user.location {
                //throttle extended region updates
                timeSinceLastUpdate = currentLocation.timestamp.timeIntervalSinceDate(lastLocation.timestamp)
            }
            
            if timeSinceLastUpdate == 0.0 || timeSinceLastUpdate >= CACHE_REGION_UPDATE_INTERVAL {
                user.location = currentLocation
                var params: [String: AnyObject] = ["lat": currentLocation.coordinate.latitude, "lon": currentLocation.coordinate.longitude, "dist": CACHE_REGION_RADIUS]
                Alamofire.request(Discoverage.Router.ItemsNear(params)).responseJSON { (_, _, data: AnyObject?, error: NSError?) -> Void in
                    if let error = error {
                        println("LOCATION_UPDATE_ERROR:")
                        println(error)
                    } else {
                        if let dictionary = data as? NSDictionary {
                            self.animalsInRegion = Animal.initWithArray(dictionary["animals"] as! [NSDictionary])
                            self.bananaTreesInRegion = BananaTree.initWithArray(dictionary["bananaTrees"] as! [NSDictionary])
                        }
                    }
                }
            }
            
            var capturedAnimals = animalsInRegion.filter({ animal in
                return animal.location.distanceFromLocation(currentLocation) <= CAPTURE_RADIUS
            }).map({ (animal: Animal) -> Animal in
                animal.owner = User.currentUser
                return animal
            })

            var capturedBananas = bananaTreesInRegion.filter({ bananaTree in
                return bananaTree.location.distanceFromLocation(currentLocation) <= CAPTURE_RADIUS
            }).map({ bananaTree in
                return BananaPick(bananaTree: bananaTree, timestamp: NSDate())
            })
            
            Alamofire.request(Discoverage.Router.Update([], capturedBananas, capturedAnimals)).responseJSON { (_, _, data: AnyObject?, error: NSError?) -> Void in
                if let error = error {
                    
                } else {
                    //println(data)
                    if let dictionary = data as? NSDictionary {
                        var animals = [Animal]()
                        var bananaPicks = [BananaPick]()
                        if let animalArray = dictionary["animals"] as? [NSDictionary] {
                            animals = Animal.initWithArray(animalArray)
                        }
                        if let bananasArray = dictionary["bananaPicks"] as? [NSDictionary] {
                            bananaPicks = BananaPick.initWithArray(bananasArray)
                        }
                        if animals.count > 0 || bananaPicks.count > 0 {
                            self.delegate?.locationManager(self, didCaptureBananas: bananaPicks, didCaptureAnimals: animals)
                        }
                    }
                }
            }
            
        } else {
            stopUpdatingLocation()
        }
        
 
    }
}
