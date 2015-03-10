//
//  Animal.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class Animal: NSObject {
    private let CLASS_NAME = "Animal"
    
    var attributes: [String: AnyObject]
    var owner: User? {
        return attributes["owner"] as? User
    }
    var health: Int? {
        return attributes["health"] as? Int
    }
    var name: String? {
        return attributes["name"] as? String
    }
    var sprite: String? {
        return attributes["sprite"] as? String
    }
    var location: CLLocation? {
        return attributes["location"] as? CLLocation
    }
    
    init(owner: User, health: Int, name: String, sprite: String, location: CLLocation) {
        attributes = [String: AnyObject]()
        attributes["owner"] = owner
        attributes["health"] = health
        attributes["name"] = name
        attributes["sprite"] = sprite
        attributes["location"] = location
    }
    
    init(object: PFObject) {
        attributes = [String: AnyObject]()
        attributes["owner"] = object.objectForKey("owner")
        attributes["health"] = object.objectForKey("health")
        attributes["name"] = object.objectForKey("name")
        attributes["sprite"] = object.objectForKey("sprite")
        attributes["location"] = object.objectForKey("location")
    }
    
    func save(block: (success: Bool, error: NSError?) -> ()) {
        ParseClient.sharedInstance.save(CLASS_NAME, attributes: attributes, block: block)
    }
    
    func get(id: String, block: (object: PFObject?, error: NSError?) -> ()) {
        ParseClient.sharedInstance.get(CLASS_NAME, id: id, block: block)
    }
    
    func fetchWhere(params: [String:String], block: (objects: [AnyObject]?, error: NSError?) -> ()) {
        ParseClient.sharedInstance.fetchWhere(CLASS_NAME, params: params, block: block)
    }


}
