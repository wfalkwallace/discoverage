//
//  Banana.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class BananaTree: NSObject {
    
    var id: String?
    var location: CLLocation
    
    var dictionary: NSDictionary?

    init(location: CLLocation) {
        self.location = location
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary["_id"] as! String
        let locationData = dictionary["location"] as! NSArray
        let lat = locationData[1] as! CLLocationDegrees
        let lon = locationData[0] as! CLLocationDegrees
        self.location = CLLocation(latitude: lat, longitude: lon)
        
        self.dictionary = dictionary
    }
    
    class func initWithArray(array: [NSDictionary]) -> [BananaTree] {
        var trees = [BananaTree]()
        for dictionary in array {
            trees.append(BananaTree(dictionary: dictionary))
        }

        return trees
    }
}