//
//  Banana.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class BananaTree {
    var location: PFGeoPoint
    var object: PFObject
    var id: Int {
        return object.objectForKey("id") as! Int
    }
    
    init(object: PFObject) {
        self.location = object.objectForKey("location") as! PFGeoPoint
        self.object = object
    }
    
    func save(block: (success: Bool, error: NSError?) -> ()) {
        object.setObject(location, forKey: "location")
        object.saveInBackgroundWithBlock(block)
    }
    
    class func initArray(results: [PFObject]) -> [BananaTree] {
        var trees = [BananaTree]()
        for result in results {
            var tree = BananaTree(object: result)
            trees.append(tree)
        }
        return trees
    }
}