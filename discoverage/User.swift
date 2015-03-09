//
//  User.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class User: NSObject {
    var email: String?
    var username: String?
    var accountID: String?
    var currentLocation: Location?
    var bananaCount: Int
    var bananas: [(banana: Banana, timestamp: NSDate)]?
    
    init(email: String, username: String, accountID: String, currentLocation: Location?, bananaCount: Int, bananas: [(banana: Banana, timestamp: NSDate)]) {
        self.email = email
        self.username = username
        self.accountID = accountID
        self.currentLocation = currentLocation
        self.bananaCount = bananaCount
        self.bananas = bananas
    }
    
}
