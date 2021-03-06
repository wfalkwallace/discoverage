//
//  BananaPick.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/10/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BananaPick: NSObject {
    var id: String?
    var bananaTree: BananaTree
    var timestamp: NSDate
    var user: User?
    var dictionary: NSDictionary?
    
    init(bananaTree: BananaTree, timestamp: NSDate) {
        self.bananaTree = bananaTree
        self.timestamp = timestamp
        self.user = User.currentUser!
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary["_id"] as! String
        self.bananaTree = BananaTree(dictionary: dictionary["bananaTree"] as! NSDictionary)
        self.user = User(dictionary: dictionary["picker"] as! NSDictionary)
        self.timestamp = NSDate(timeIntervalSince1970: dictionary["timestamp"] as! NSTimeInterval)
        self.dictionary = dictionary
    }
    
    func serialize() -> [String: AnyObject] {
        var params = [String: AnyObject]()
        params["bananaTree"] = bananaTree.id
        params["timestamp"] = timestamp.timeIntervalSince1970
        params["picker"] = user?.id
        if let id = id {
            params["_id"] = id
        }
        return params
    }
    
    func save(block: (bananaPick: BananaPick, error: NSError?) -> ()) {
        var params = serialize()
        
        Alamofire.request(Discoverage.Router.BananaPickCreate(params)).responseJSON { (_, _, data, error) in
            // todo: save dict and call block
        }
    }
    
    class func initWithArray(array: [NSDictionary]) -> [BananaPick] {
        var picks = [BananaPick]()
        
        for dictionary in array {
            picks.append(BananaPick(dictionary: dictionary))
        }
        
        return picks
    }

}
