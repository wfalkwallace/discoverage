//
//  BananaPick.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/10/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class BananaPick {
    var bananaTree: BananaTree
    var timestamp: NSDate
    
    init(bananaTree: BananaTree, timestamp: NSDate) {
        self.bananaTree = bananaTree
        self.timestamp = timestamp
    }
}
