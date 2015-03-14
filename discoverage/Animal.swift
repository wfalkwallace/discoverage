//
//  Animal.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class Animal: NSObject {
    var owner: String
    var health: Int
    var name: String
    var sprite: String
   // var location: PFGeoPoint
    var object : PFObject

    init(object: PFObject) {
        
        self.owner = "" //object.objectForKey("owner") as! String
        self.name = object.objectForKey("name") as! String
        self.sprite = object.objectForKey("sprite") as! String
        self.health = object.objectForKey("health") as! Int
        //self.location = object.objectForKey("location") as! PFGeoPoint
        self.object = object
    }
    
    class func initWithArray(results: [PFObject]) -> [Animal] {
        var animals = [Animal]()
        for result in results {
            var animal = Animal(object: result)
            animals.append(animal)
        }
        return animals
    }
    
//    func feed () {
//        if (health <= 10 && owner.bananaCount > 0) {
//            self.health = self.health + 1
//        }
//    }
    
    //this method should have a completion block
    class func animalsForUserAndCompletion(userName: String, completion: (animals: [Animal]?, error: NSError?) -> ()) {

        
        User.queryWithName(userName) {
            (usr: User?, error: NSError?) in
            if error == nil {
                var user = usr
                
                println(user!.name)
                println(user!.userId!)
                println(user!.email)
                
                var query = PFQuery(className:"Animal")
                query.whereKey("owner", equalTo: user!.userId!)
            
                query.findObjectsInBackgroundWithBlock { (results: [AnyObject]?, error: NSError?) -> Void in
                    if error == nil {
                        println("Successfully retrieved \(results?.count) animals.")
                        if let objects = results as? [PFObject] {
                            var animals = Animal.initWithArray(objects)
                            completion(animals: animals, error: nil)
                        }
                    }
                    else {
                        // Log details of the failure
                        println("failed to get animals for user")
                        completion(animals: nil, error: error)
                    }
                }
                
            } else {
                completion(animals: nil, error: error)
            }
        }
    }
    
    //this method should have a completion block
    class func query() -> [Animal] {
        
        var pfObjects = [PFObject]()
        
        var query = PFQuery(className:"Animal")
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

        return Animal.initWithArray(pfObjects)
    }
}
