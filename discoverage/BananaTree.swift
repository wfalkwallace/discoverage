//
//  Banana.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class BananaTree: NSObject {
    private let CLASS_NAME = "BananaTree"

    var attributes: [String: AnyObject]
    var location: CLLocation? {
        return attributes["location"] as? CLLocation
    }
    
    init(location: CLLocation) {
        attributes = [String: AnyObject]()
        attributes["location"] = location
    }
    
    init(object: PFObject) {
        attributes = [String: AnyObject]()
        attributes["location"] = object.objectForKey("location")
    }
    
    func save(block: (success: Bool, error: NSError?) -> ()) {
        ParseClient.sharedInstance.save(CLASS_NAME, attributes: attributes, block: block)
    }
    
    func get(id: String, block: (object: PFObject?, error: NSError?) -> ()) {
        ParseClient.sharedInstance.get(CLASS_NAME, id: id, block: block)
    }
    
    func fetchWhere(params: [String:String], block: (objects: [AnyObject]?, error: NSError?) -> ()) {
        ParseClient.sharedInstance.fetchWhere(CLASS_NAME, params: params, block: block)
    }
}
