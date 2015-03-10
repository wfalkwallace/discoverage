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
    let ID: String
    let name: String
//    let sprite: UIImage? TODO
   
    init (name: String, sprite: UIImage) {
        // TODO load from parse
        self.health = 10
        self.ID = "xyz"
        self.name = "Charizard"
    }
    
    func adopt (owner: User) {
        self.owner = owner
    }
    
    func feed () {
        if (health <= 10 && owner?.numBananas > 0) {

            self.health = self.health + 1
        }
    }
}
