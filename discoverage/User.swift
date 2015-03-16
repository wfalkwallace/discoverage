//
//  User.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/6/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var _currentUser: User?
let currentUserKey = "CurrentUser"

class User {

    var id: String?
    var name: String
    var bananaCount: Int
    var location: CLLocation?

    var dictionary: NSDictionary?

    init(name: String, email: String, bananaCount: Int, location: CLLocation) {
        self.name = name
        self.location = location
        self.bananaCount = bananaCount
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary["_id"] as! String
        self.name = dictionary["name"] as! String
        
        let locationData = dictionary["location"] as! NSDictionary
        let lat = locationData["lat"] as! CLLocationDegrees
        let lon = locationData["lon"] as! CLLocationDegrees
        self.location = CLLocation(latitude: lat, longitude: lon)
        
        self.bananaCount = dictionary["bananaCount"] as! Int
        self.dictionary = dictionary
    }
    
    func save(block: (user: User, error: NSError?) -> ()) {
        var params = [String: AnyObject]()
        params["name"] = name
        params["bananaCount"] = bananaCount
        if let location = location {
            params["location"] = ["lat": location.coordinate.latitude, "lon": location.coordinate.longitude]
        }
        if let id = id {
            params["_id"] = id
        }
        
        Alamofire.request(Discoverage.Router.User(params)).responseJSON { (_, _, data, error) in
            // todo: save dict and call block
            println(data)
            println(error)
        }
    }
    
    class func initWithArray(array: [NSDictionary]) -> [User] {
        var users = [User]()
        
        for dictionary in array {
            users.append(User(dictionary: dictionary))
        }
        
        return users
    }
    
    class func logout() {
        User.currentUser = nil
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
    
    func claimBananasAndAnimals() {
        
//        println(self.location!)
//        
//        let bananaPicks : [BananaPick]  = BananaPick.BananaPicksInRange(self.location, 10.0)
//        let animals : [Animal] = Animal.AnimalsInRange(self.location, 10.0)
//        
//        for animal in animals {
//            animal.setOwner(self)
//        }
//        
//        for bananaPick in bananaPicks {
//            bananaPick.setPicker(self)
//            self.bananaCount += 1
//        }
//        save()
//        //refresh views using notifications
//        NSNotificationCenter.defaultCenter().postNotificationName("updateViews", object: nil)

    }
}
