//
//  ParseClient.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/10/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class ParseClient: NSObject {
    
    class var sharedInstance: ParseClient {
        struct Static {
            static let instance = ParseClient()
        }
        
        return Static.instance
    }
    
    func save(className: String, attributes: [String:AnyObject], block: (success: Bool, error: NSError?) -> ()) {
        var object = PFObject(className: className)
        for (key, value) in attributes {
            object.setObject(value, forKey: key)
        }
        object.saveInBackgroundWithBlock(block)
    }
    
    func get(className: String, id: String, block: (object: PFObject?, error: NSError?) -> ()) {
        var query = PFQuery(className: className)
        query.getObjectInBackgroundWithId(id, block: block)
    }
    
    func fetchWhere(className: String, params: [String:String], block: (objects: [AnyObject]?, error: NSError?) -> ()) {
        var query = PFQuery(className: className)
        for (key, value) in params {
            query.whereKey(key, equalTo:value)
        }
        query.findObjectsInBackgroundWithBlock(block)
    }
    
}
