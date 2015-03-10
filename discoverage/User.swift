//
//  User.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class User: NSObject {
    private let CLASS_NAME = "User"
    
    var attributes: [String: AnyObject]
    var email: String? {
        return attributes["email"] as? String
    }
    var currentLocation: CLLocation? {
        return attributes["currentLocation"] as? CLLocation
    }
    var bananaCount: Int? {
        return attributes["bananaCount"] as? Int
    }

    init(email: String, currentLocation: CLLocation, bananaCount: Int) {
        attributes = [String: AnyObject]()
        attributes["email"] = email
        attributes["currentLocation"] = currentLocation
        attributes["bananaCount"] = bananaCount
    }
    
    init(object: PFObject) {
        attributes = [String: AnyObject]()
        attributes["email"] = object.objectForKey("email")
        attributes["currentLocation"] = object.objectForKey("currentLocation")
        attributes["bananaCount"] = object.objectForKey("bananaCount")
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
