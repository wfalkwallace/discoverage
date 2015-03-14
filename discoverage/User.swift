//
//  User.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "CurrentUser"

class User {

    var userId: String?
    var name: String
    var email: String
    var location: PFGeoPoint?
    var lastLocationUpdate: NSDate?
    var bananaCount: Int
    private var object: PFObject!
    var id: Int {
        return object.objectForKey("id") as! Int
    }
    //var location: PFGeoPoint
    //var lastLocationUpdate: NSDate?
    //var bananaPicks: [BananaPick]
    //var bananaPicks: [BananaPick]

    /*init (dictionary: NSDictionary) {
        name = dictionary["name"] as! String
        email = dictionary["email"] as! String
        bananaCount = dictionary["bananaCount"] as! Int
        let picks = dictionary["bananaPicks"] as! [NSDictionary]
        //bananaPicks = picks.map {
          //  (var pick) -> NSDictionary in
           // return BananaPick() // <- Not finished
        //}
    }*/
    
    init(name: String, email: String, bananaCount: Int) {
        self.name = name
        self.email = email
        self.bananaCount = bananaCount
        self.object = PFObject(className:"User")
        self.sync()
    }
    
    init(object: PFObject) {
        self.userId = object.objectId!
        self.name = object.objectForKey("userName") as! String
        self.email = object.objectForKey("email") as! String
        //self.location = object.objectForKey("location") as! PFGeoPoint
        self.bananaCount = object.objectForKey("bananaCount") as! Int
        self.name = object.objectForKey("name") as! String
        self.email = object.objectForKey("email") as! String
        self.object = object
    }
    
    func sync () {
        object.setObject(self.name, forKey: "name")
        object.setObject(self.email, forKey: "email")
        object.setObject(self.bananaCount, forKey: "bananaCount")
    }

    class func queryWithName(name : String, completion: (user: User?, error: NSError?) -> ()) {
        var query = PFQuery(className:"User")
        
        query.whereKey("name", equalTo: name)
        query.findObjectsInBackgroundWithBlock { (results: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                println("Successfully retrieved \(results?.count) users")
                if let objects = results as? [PFObject] {
                    var user = User(object: objects[0])
                    completion(user: user, error: nil)
                }
            }
            else {
                println("failed")
                completion(user: nil, error: error)
            }
        }
    }

    class func queryWithId(id: String, completion: (user: User?, error: NSError?) -> ()) {
        var query = PFQuery(className:"User")
        query.getObjectInBackgroundWithId(id) {
            (object: PFObject?, error: NSError?) -> Void in
            
            if let object = object {
                completion(user: User(object: object), error: nil)
            } else {
                println("couldn't get user")
                completion(user: nil, error: error)
            }
        }
    }
    
    func logout() {
        User.currentUser = nil
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                if let user = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? User {
                    _currentUser = user
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                NSUserDefaults.standardUserDefaults().setObject(_currentUser, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
