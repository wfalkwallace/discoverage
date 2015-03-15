//
//  Animal.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class Animal: NSObject {
    var owner: User?
    var health: Int!
    var name: String!
    var sprite: String!
    var object : PFObject!

    init(object: PFObject) {
        super.init()
        
        User.queryWithId(object.objectForKey("owner") as! String, completion: { (user, error) -> () in
            self.owner = user!
        })

        self.name = object.objectForKey("name") as! String
        self.sprite = object.objectForKey("sprite") as! String
        self.health = object.objectForKey("health") as! Int
        self.object = object
    }
    
    init(object: PFObject, owner: User) {
        super.init()
        
        self.owner = owner
        self.name = object.objectForKey("name") as! String
        self.sprite = object.objectForKey("sprite") as! String
        self.health = object.objectForKey("health") as! Int
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
    
    func sync () {
        self.object.setObject(self.name, forKey: "name")
        if let id = self.owner?.id {
            self.object.setObject(id, forKey: "owner")
        }
        self.object.setObject(self.health, forKey: "health")
        self.object.setObject(self.sprite, forKey: "sprite")
    }
    
    func save (block: (success: Bool, error: NSError?) -> ()) {
        sync()
        object.saveInBackgroundWithBlock(block)
    }
    
    func feed () {
        if (health <= 10 && owner?.bananaCount > 0) {
            self.health = self.health + 1
        }
    }
    
    //this method should have a completion block
    class func animalsForUserAndCompletion(userName: String, completion: (animals: [Animal]?, error: NSError?) -> ()) {

        
        User.queryWithName(userName) {
            (usr: User?, error: NSError?) in
            if error == nil {
                var user = usr
                var query = PFQuery(className:"Animal")
                query.whereKey("owner", equalTo: user!.userId!)
            
                query.findObjectsInBackgroundWithBlock { (results: [AnyObject]?, error: NSError?) -> Void in
                    if error == nil {
                        println("Successfully retrieved \(results?.count) animals.")
                        if let objects = results as? [PFObject] {
                            var animals = [Animal]()
                            for object in objects {
                                var animal = Animal(object: object, owner: user!)
                                animals.append(animal)
                            }
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
