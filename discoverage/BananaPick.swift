//
//  BananaPick.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/10/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class BananaPick: PFObject, PFSubclassing {
    @NSManaged var bananaTree: BananaTree
    @NSManaged var timestamp: NSDate
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String! {
        return "BananaPick"
    }
}
