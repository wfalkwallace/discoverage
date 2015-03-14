//
//  Banana.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class BananaTree {
    let location: PFGeoPoint
    private let object: PFObject
    var id: Int {
        return object.objectForKey("id") as! Int
    }
    
    init(object: PFObject) {
        self.location = object.objectForKey("location") as! PFGeoPoint
        self.object = object
    }

// Probably don't need this
//    init(location: PFGeoPoint) {
//        self.object = PFObject(className: "BananaTree")
//        self.location = location
//    }
    
    func save(block: (success: Bool, error: NSError?) -> ()) {
        object.setObject(location, forKey: "location")
        object.saveInBackgroundWithBlock(block)
    }
    
    class func initWithArray(results: [PFObject]) -> [BananaTree] {
        var trees = [BananaTree]()
        for result in results {
            var tree = BananaTree(object: result)
            trees.append(tree)
        }
        return trees
    }
}