//
//  Animal.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Animal: NSObject {
    var id: String?
    var owner: User?
    var health: Int
    var name: String
    var sprite: String
    var location: CLLocation
    var dictionary: NSDictionary?

    init(health: Int, name: String, sprite: String, location: CLLocation, owner: User) {
        self.owner = owner
        self.name = name
        self.sprite = sprite
        self.health = health
        self.location = location
    }
    
    init(dictionary: NSDictionary) {
        self.owner = User(dictionary: dictionary["owner"] as! NSDictionary)
        self.name = dictionary["name"] as! String
        self.id = dictionary["_id"] as! String
        self.sprite = dictionary["sprite"] as! String
        self.health = dictionary["health"] as! Int
        
        let locationData = dictionary["location"] as! NSArray
        let lat = locationData[0] as! CLLocationDegrees
        let lon = locationData[1] as! CLLocationDegrees
        self.location = CLLocation(latitude: lat, longitude: lon)

        self.dictionary = dictionary
    }
    
    func reset(dictionary: NSDictionary) {
        self.owner = User(dictionary: dictionary["owner"] as! NSDictionary)
        self.name = dictionary["name"] as! String
        self.id = dictionary["_id"] as! String
        self.sprite = dictionary["sprite"] as! String
        self.health = dictionary["health"] as! Int
        
        let locationData = dictionary["location"] as! NSArray
        let lat = locationData[0] as! CLLocationDegrees
        let lon = locationData[1] as! CLLocationDegrees
        self.location = CLLocation(latitude: lat, longitude: lon)
        
        self.dictionary = dictionary
    }
    
    class func initWithArray(array: [NSDictionary]) -> [Animal] {
        var animals = [Animal]()
        
        for dictionary in array {
            animals.append(Animal(dictionary: dictionary))
        }
        
        return animals
    }
    
    func save(block: (animal: Animal?, error: NSError?) -> ()) {
        var params = [String: AnyObject]()
        params["location"] = ["lat": location.coordinate.latitude, "lon": location.coordinate.longitude]
        params["owner"] = owner
        params["name"] = name
        params["health"] = health
        params["sprite"] = sprite
        if let id = id {
            params["_id"] = id
        }
        
        Alamofire.request(Discoverage.Router.Animal(params)).responseJSON { (_, _, data, error) in
            if error == nil {
                println(data)
                self.reset(data as! NSDictionary)
                block(animal: self, error: nil)
            } else {
                block(animal: nil, error: error)
                println(error)
            }
        }
    }
    
    func feed () {
        if (health < 10 && owner?.bananaCount > 0) {
            self.health = self.health + 1
        }
    }
}
