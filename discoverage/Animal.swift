//
//  Animal.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class Animal: NSObject {
    var owner: User?
    var health: Int
    let name: String!
    let sprite: UIImage!
   
    init (name, sprite) {
        
    }
    
    func adopt () {}
    func runAway () {}
    func feed () {}
}
