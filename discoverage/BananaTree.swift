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

class BananaTree {
    var id: String?
    var location: CLLocation
    var dictionary: NSDictionary?

    init(location: CLLocation) {
        self.location = location
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary["_id"] as! String
        let locationData = dictionary["location"] as! NSDictionary
        let lat = locationData["lat"] as! CLLocationDegrees
        let lon = locationData["lon"] as! CLLocationDegrees
        
        self.location = CLLocation(latitude: lat, longitude: lon)
        self.dictionary = dictionary
    }
    
    func save(block: (bananaTree: BananaTree, error: NSError?) -> ()) {
        var params = [String: AnyObject]()
        params["lat"] = location.coordinate.latitude
        params["lon"] = location.coordinate.longitude
        if let id = id {
            params["_id"] = id
        }
        
        Alamofire.request(Discoverage.Router.BananaTree(params)).responseJSON { (_, _, data, error) in
            // todo: save dict and call block
            println(data)
            println(error)
        }
    }
    
    class func initWithArray(array: [NSDictionary]) -> [BananaTree] {
        var trees = [BananaTree]()
        
        for dictionary in array {
            trees.append(BananaTree(dictionary: dictionary))
        }

        return trees
    }
}