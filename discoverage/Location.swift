//
//  Location.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class Location: NSObject {
    var lat: String?
    var lon: String?
    
    init(lat: String, lon: String) {
        self.lat = lat
        self.lon = lon
    }
    
}
