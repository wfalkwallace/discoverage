//
//  User.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class User: PFObject, PFSubclassing {
    
    var email: String {
        get {
            return objectForKey("email") as! String
        }
        set {
            setObject(newValue, forKey: "email")
        }
    }
    var username: String {
        get {
            return objectForKey("username") as! String
        }
        set {
            setObject(newValue, forKey: "username")
        }
    }
    var accountID: String {
        get {
            return objectForKey("accountID") as! String
        }
        set {
            setObject(newValue, forKey: "accountID")
        }
    }
    var currentLocation: PFGeoPoint {
        get {
            return objectForKey("currentLocation") as! PFGeoPoint
        }
        set {
            setObject(newValue, forKey: "currentLocation")
        }
    }
    var bananaCount: Int {
        get {
            return objectForKey("bananaCount") as! Int
        }
        set {
            setObject(newValue, forKey: "bananaCount")
        }
    }
    // refactor to capture class
    // var bananas: [(bananaTree: BananaTree, timestamp: NSDate)]

    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String! {
        return "User"
    }
    
}
