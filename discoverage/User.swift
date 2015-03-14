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

    
    var name: String
    var email: String
    var location: PFGeoPoint?
    var lastLocationUpdate: NSDate?
    var bananaCount: Int
    private var object: PFObject

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
    
    init(object: PFObject) {
        self.name = object.objectForKey("userName") as! String
        self.email = object.objectForKey("email") as! String
        self.location = object.objectForKey("location") as? PFGeoPoint
        self.bananaCount = object.objectForKey("bananaCount") as! Int
        self.object = object
    }
    
    class func initWithObject(results: [PFObject]) -> User {
        var result = results[0]
        var user = User(object: result)
        return user
    }
    
    //this method should have a completion block
    class func queryWithName(userName : String) -> [PFObject] {
        
        var user:User?
        var query = PFQuery(className:"User")
        var pfObjects = [PFObject]()
        
        query.whereKey("userName", equalTo: userName)
        query.findObjectsInBackgroundWithBlock { (results: [AnyObject]?, error: NSError?) -> Void in
            // The find succeeded.
            println("Successfully retrieved \(results?.count) animals.")
            if let objects = results as? [PFObject] {
                for object in objects {
                    pfObjects.append(object)
                }
            }
            else {
                // Log details of the failure
                println("failed")
            }
        }
        return pfObjects
    }
    
    //this method should have a completion block
    class func queryWithId(userId: String) -> User {
        
        var query = PFQuery(className:"User")
        var user:User?

        query.getObjectInBackgroundWithId(userId) {
        (PFObjectResultBlock) -> Void in
            if PFObjectResultBlock.0 != nil {
                user = User(object: PFObjectResultBlock.0!)
            
            } else {
                println("couldnt get user")
            }
        }
        //seems dangerous
        return user!
    }
    
    func logout() {
        _currentUser = nil
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
