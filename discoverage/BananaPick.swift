//
//  BananaPick.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/10/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class BananaPick {
    let bananaTree: BananaTree
    let timestamp: NSDate
    let user: User
    private let object: PFObject!
    var id: Int {
        return object.objectForKey("id") as! Int
    }
    
    init(bananaTree: BananaTree, timestamp: NSDate) {
        self.bananaTree = bananaTree
        self.timestamp = timestamp
        self.user = User.currentUser!
        self.object = createObject()
    }
    
    func createObject () -> PFObject {
        var object = PFObject(className:"BananaTree")
        object.setObject(self.bananaTree.id, forKey: "bananaTree")
        object.setObject(self.timestamp, forKey: "timestamp")
        object.setObject(self.user.id, forKey: "user")
        return object
    }
    
    func save (block: (success: Bool, error: NSError?) -> ()) {
        object.saveInBackgroundWithBlock(block)
    }
}
