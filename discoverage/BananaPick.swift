//
//  BananaPick.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/10/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class BananaPick {
    var bananaTree: BananaTree
    var timestamp: NSDate
    var user: User
    var object: PFObject
    
    init(bananaTree: BananaTree, timestamp: NSDate) {
        self.bananaTree = bananaTree
        self.timestamp = timestamp
        self.user = User.currentUser!
    }
    
    func createObject () -> PFObject {
        var bananaTree = PFObject(className:"BananaTree")
        bananaTree.setObject(self.bananaTree.object.objectId!, forKey: "bananaTree")
        bananaTree.setObject(self.timestamp, forKey: "timestamp")
        bananaTree.setObject(self.user.object.objectId!, forKey: "user")
        return bananaTree
    }
}
