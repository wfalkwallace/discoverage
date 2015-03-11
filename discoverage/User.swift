//
//  User.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class User: NSObject {
    var bananaCount: Int = 14
    var name: String = "User"
    var menagerie : Menagerie = Menagerie()
    
    override init () {
        super.init()
    }
}
