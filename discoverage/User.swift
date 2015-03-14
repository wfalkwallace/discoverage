//
//  User.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class User {
    let name: String
    let email: String
    var bananaCount: Int
    private let object: PFObject!
    var id: Int {
        return object.objectForKey("id") as! Int
    }
    
    init(name: String, email: String, bananaCount: Int) {
        self.name = name
        self.email = email
        self.bananaCount = bananaCount
        self.object = createObject()
    }
    
    init(object: PFObject) {
        self.bananaCount = object.objectForKey("bananaCount") as! Int
        self.name = object.objectForKey("name") as! String
        self.email = object.objectForKey("email") as! String
        self.object = object
    }
    
    func createObject () -> PFObject {
        var object = PFObject(className:"User")
        object.setObject(self.name, forKey: "name")
        object.setObject(self.email, forKey: "email")
        object.setObject(self.bananaCount, forKey: "bananaCount")
        return object
    }

    //hack
    class var currentUser : User? {
        get {
            var user = User(name: "aditya", email: "aditya@email.com", bananaCount: 10)
            return user
        }
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
