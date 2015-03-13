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
    var health: Float
    var name: String
    var sprite: String
    var location: PFGeoPoint

    init(dictionary: NSDictionary) {
        println(dictionary)
        
        health = dictionary["health"] as! Float
        name = dictionary["name"] as! String
        sprite = dictionary["sprite"] as! String
        location = PFGeoPoint(latitude: dictionary["lat"] as! Double, longitude: dictionary["long"] as! Double)
    }

    func feed () {
        if (health <= 10 && owner?.bananaCount > 0) {
            self.health = self.health + 1
        }
    }
}
