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
        self.location = CLLocation
        self.dictionary = dictionary
    }

    init(location: CLLocation) {
        self.location = location
    }
    
    func save(block: (bananaTree: BananaTree, error: NSError?) -> ()) {
        Alamofire
        self.dictionary =
    }
    
    class func initWithArray(results: [PFObject]) -> [BananaTree] {
        var trees = [BananaTree]()
        for result in results {
            var tree = BananaTree(object: result)
            trees.append(tree)
        }
        return trees
    }
}