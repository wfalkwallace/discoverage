//
//  User.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class User {
    var userId: String?
    var name: String
    var email: String
    var bananaCount: Int
    //var location: PFGeoPoint
    //var lastLocationUpdate: NSDate?
    //var bananaPicks: [BananaPick]
    var bananaPicks: [BananaPick]
    var object: PFObject

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
        //self.location = location
        self.bananaCount = bananaCount
        //save
    }
    
    init(object: PFObject) {
        self.userId = object.objectId
        self.name = object.objectForKey("userName") as! String
        self.email = object.objectForKey("email") as! String
        //self.location = object.objectForKey("location") as! PFGeoPoint
        self.bananaCount = object.objectForKey("bananaCount") as! Int
        self.name = object.objectForKey("userName") as! String
        self.email = object.objectForKey("email") as! String
        self.location = object.objectForKey("location") as? PFGeoPoint
        self.bananaCount = object.objectForKey("bananaCount") as! Int
        self.object = object
    }
    
    class func initWithObjects(results: [PFObject]) -> User {
        var result = results[0]
        var user = User(object: result)
        return user
    }

    //hack
    class var currentUser : User? {
        get {
            var user = User(name: "aditya", email: "aditya@email.com", bananaCount: 10)
            user.userId = "Dt3mVAh05F"
            return user
        }
    }

    
    class func queryWithNameAndCompletion(userName : String, completion: (user: User?, error: NSError?) -> ()) {
        var query = PFQuery(className:"User")
        
        query.whereKey("userName", equalTo: userName)
        query.findObjectsInBackgroundWithBlock { (results: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                println("Successfully retrieved \(results?.count) users")
                if let objects = results as? [PFObject] {
                    var user = User.initWithObjects(objects)
                    completion(user: user, error: nil)
                }
            }
            else {
                println("failed")
                completion(user: nil, error: error)
            }
        }
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
        //seems dangerous, user could be nil if getObjectInBackgroundWithId fails
        return user!
    }
}
