//
//  User.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class User: NSObject {
    var numBananas: Int
    var name: String
    
    override init () {
        self.name = "User"
        self.numBananas = 3
    }
}
