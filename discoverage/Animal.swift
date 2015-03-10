//
//  Animal.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class Animal: PFObject, PFSubclassing {
    
    dynamic var owner: User?
    dynamic var health: NSNumber?
    dynamic let name: String?
    dynamic let sprite: String?
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String! {
        return "Animal"
    }

}
