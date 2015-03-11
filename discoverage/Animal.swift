//
//  Animal.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class Animal: PFObject, PFSubclassing {
    @NSManaged var owner: User?
    @NSManaged var health: NSInteger
    @NSManaged var name: NSString
    @NSManaged var sprite: NSString
    @NSManaged var location: PFGeoPoint

    override init() {
        super.init()
    }

    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }

    func parseClassName() -> String! {
        return "Animal"
    }

}
