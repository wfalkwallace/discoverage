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
        name = "jehan"
        animals.append(Animal(dictionary: ["name" : "bulbasaur", "sprite" : "1_bulbasaur", "health" : 0.1, "lat": 37, "long": 122 ]))
        email = "jehan.tremback@gmail.com"
        currentLocation = PFGeoPoint(latitude: 37.7833, longitude: 122.4167)
        lastLocationUpdate = NSDate(timeIntervalSince1970: 1426209264)
        bananaCount = 12
        bananaPicks = []
    }
}
