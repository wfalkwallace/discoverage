//
//  User.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class User {
    var name: String
    var animals: [Animal] = []
    var email: String
    var currentLocation: PFGeoPoint?
    var lastLocationUpdate: NSDate?
    var bananaCount: Int
    var bananaPicks: [BananaPick]

    init (dictionary: NSDictionary) {
        name = dictionary["name"] as! String
        animals.append(Animal(dictionary: ["name" : "bulbasaur", "sprite" : "1_bulbasaur", "health" : 0.1, "lat": 37, "long": 122 ]))
        email = dictionary["email"] as! String
        bananaCount = dictionary["bananaCount"] as! Int
        let picks = dictionary["bananaPicks"] as! [NSDictionary]
        bananaPicks = picks.map {
            (var pick) -> NSDictionary in
            return BananaPick() // <- Not finished
        }
    }
}
