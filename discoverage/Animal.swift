//
//  Animal.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class Animal: NSObject {
    var name : String = "Charizard"
    var owner: User?
    var health : Float = 0.0
    let sprite: String = "noimage"
    var location : Location?
    var totalBananasEaten : Int = 0
    var mood : String = "Hungry"
    //let ID: String?
    
    func adopt (owner: User) {
        self.owner = owner
    }
    
    func feed () {
        if (health <= 10 && owner?.bananaCount > 0) {

            self.health = self.health + 1
        }
    }
}
