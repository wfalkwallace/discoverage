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
    let location: CLLocation
    let dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        let locationData = dictionary["location"] as! [String:CLLocationDegrees]
        self.location = CLLocation(latitude: locationData["lat"]!, longitude: locationData["lon"]!)
        self.dictionary = dictionary
    }

    init(location: CLLocation) {
        self.location = location
    }
    
    func save(block: (bananaTree: BananaTree, error: NSError?) -> ()) {
        var params = [String: AnyObject]()
        params["lat"] = location.coordinate.latitude
        params["lon"] = location.coordinate.longitude
        if let id = id {
            params["id"] = id
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