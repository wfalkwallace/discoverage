//
//  Banana.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class BananaTree: NSObject {
    var location: CLLocation!

    init(location: CLLocation) {
        self.location = location
    }
    
    func save(block: (success: Bool, error: NSError?) -> ()) {
        var bananaTree = PFObject(className: "BananaTree")
        bananaTree.setObject(location, forKey: "location")
        bananaTree.saveInBackgroundWithBlock(block)
    }
    
    func get(id: String, block: (bananaTree: PFObject?, error: NSError?) -> ()) {
        var query = PFQuery(className: "BananaTree")
        query.getObjectInBackgroundWithId(id, block: block)
    }
    
    func fetchWhere(params: [String:String], block: (bananaTrees: [AnyObject]?, error: NSError?) -> ()) {
        
        var query = PFQuery(className:"BananaTree")
        for (key, value) in params {
            query.whereKey(key, equalTo:value)
        }

        query.findObjectsInBackgroundWithBlock(block)
    }
    
    func fetchAll(block: (success: Bool, error: NSError?) -> ()) {
        var bananaTree = PFObject(className: "BananaTree")
        bananaTree.setObject(location, forKey: "location")
        bananaTree.saveInBackgroundWithBlock(block)
    }
}
