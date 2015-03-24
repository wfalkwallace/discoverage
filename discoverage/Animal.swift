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
import MapKit

class Animal: NSObject {
    var id: String?
    var owner: User?
    var health: Int
    var location: CLLocation
    var names : NSArray
    var sprites: NSArray
    var name : String
    var sprite : String
    var dictionary: NSDictionary?
    
    var _name: String {
        get {
            let index = IndexFor(self.names)
            if index == -1 {
                //println(_name)
                return name
            } else {
                return names[index] as! String
            }
        }
        set(name) {
            self.name = name
        }
    }
    var _sprite: String {
        get {
            let index = IndexFor(self.sprites)
            if index == -1 {
                println(sprite)
                return sprite
                
            } else {
                return sprites[index] as! String
            }
        }
        set(sprite) {
            self._sprite = sprite
        }
    }
    
    static let FULL_HEALTH: Int = 10

    init(owner: User) {
        self.owner = owner
        
        self.name = "Charmander"
        self.sprite = "4_charmander"
        self.names = ["Charmander", "Charmeleon", "Charizard"]
        self.sprites = ["4_charmander", "5_charmeleon", "6_charizard"]
        self.health = 6
        
        self.location = owner.location ?? CLLocation(latitude: 37, longitude: 122)
    }
    
    init(dictionary: NSDictionary) {
        if let user = dictionary.objectForKey("owner") as? NSDictionary {
            self.owner = User(dictionary: user)
        }

        self.name = dictionary["name"] as! String
        self.names = dictionary["names"] as! NSArray
        self.id = dictionary["_id"] as! String
        self.sprite = dictionary["sprite"] as! String
        self.sprites = dictionary["sprites"] as! NSArray
        self.health = dictionary["health"] as! Int
        
        let locationData = dictionary["location"] as! NSArray
        let lat = locationData[1] as! CLLocationDegrees
        let lon = locationData[0] as! CLLocationDegrees
        self.location = CLLocation(latitude: lat, longitude: lon)

        self.dictionary = dictionary
    }
    
    func reset(dictionary: NSDictionary) {
        self.owner = User(dictionary: dictionary["owner"] as! NSDictionary)
        self.names = dictionary["names"] as! NSArray
        self.name = dictionary["name"] as! String

        self.id = dictionary["_id"] as! String
        self.sprites = dictionary["sprites"] as! NSArray
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
    
    func serialize() -> [String: AnyObject] {
        var params = [String: AnyObject]()
        params["location"] = [location.coordinate.longitude, location.coordinate.latitude]
        params["owner"] = owner?.id
        params["name"] = name
        params["health"] = health
        params["sprite"] = sprite
        params["sprites"] = sprites
        params["names"] = names
        params["_id"] = id
        return params
    }
    
    func save(block: (animal: Animal?, error: NSError?) -> ()) {
        var params = serialize()
        
        Alamofire.request(Discoverage.Router.AnimalUpdate(id!, params)).responseJSON { (_, _, data, error) in
            if error == nil {
                self.reset(data as! NSDictionary)
                block(animal: self, error: nil)
            } else {
                block(animal: nil, error: error)
            }
        }
    }
    
    func feed(block: (animal: Animal?, success: Bool) -> ()) {
        // TODO confirm owner == currentUser
        if (User.currentUser!.bananaCount > 0 &&  health < 10) {
            
            User.currentUser!.bananaCount -= 1
            health += 1
            Alamofire.request(Discoverage.Router.Update([User.currentUser!], [], [self])).responseJSON { (_, _, data: AnyObject?, error: NSError?) -> Void in
                if let dictionary = data as? NSDictionary {
                    User.currentUser!.reset((dictionary["users"] as! [NSDictionary])[0]) //hack, but we know it's only one.
                    var animal = Animal.initWithArray(dictionary["animals"] as! [NSDictionary])[0] //hack, but we know it's only one.
                    block(animal: animal, success: (error == nil))
                }
            }
        } else {
            //cantfeed
        }
    }
    

    func IndexFor(array: NSArray) -> Int {
        //hack because the server sends this
        if array.count == 1 {
            if array[0].length == 0 {
                return -1
            }
        }
        switch (array.count) {
        case 0:
            return -1
        case 1:
            return 0
        case 2:
            switch(health) {
            case 0...5:
                return 0
            case 6...10:
                return 1
            default:
                return -1
            }
        case 3:
            switch(health) {
            case 0...4:
                return 0
            case 5...8:
                return 1
            case 9...10:
                return 2
            default:
                return -1
            }
        default:
            return -1
        }
    }
    
}
