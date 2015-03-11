//
//  User.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class User: PFObject, PFSubclassing {
    @NSManaged var name: String
    @NSManaged var menagerie: Menagerie
    @NSManaged var email: NSString
    @NSManaged var currentLocation: PFGeoPoint?
    @NSManaged var lastLocationUpdate: NSDate?
    @NSManaged var bananaCount: NSInteger
    @NSManaged var bananas: [BananaPick]

    override init () {
        super.init()
    }

    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }

    static func parseClassName() -> String! {
        return "User"
    }
}
