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
import MapKit

var _currentUser: User?
let currentUserKey = "CurrentUser"

class User {
    var id: String
    var token: String?
    var name: String
    var email: String
    var bananaCount: Int
    var location: CLLocation?

    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.id = dictionary["_id"] as! String
        self.name = dictionary["name"] as! String
        self.email = dictionary["email"] as! String
        
        self.token = dictionary["token"] as? String
      //  let locationData = dictionary["location"] as! NSDictionary
//        let lat = locationData["lat"] as! CLLocationDegrees
//        let lon = locationData["lon"] as! CLLocationDegrees
//        self.location = CLLocation(latitude: lat, longitude: lon)
        
        self.bananaCount = dictionary["bananaCount"] as! Int
        self.dictionary = dictionary
    }
    
    func reset(dictionary: NSDictionary) {
        self.id = dictionary["_id"] as! String
        self.name = dictionary["name"] as! String
        self.email = dictionary["email"] as! String

        //  let locationData = dictionary["location"] as! NSDictionary
        //        let lat = locationData["lat"] as! CLLocationDegrees
        //        let lon = locationData["lon"] as! CLLocationDegrees
        //        self.location = CLLocation(latitude: lat, longitude: lon)
        
        self.bananaCount = dictionary["bananaCount"] as! Int
        self.dictionary = dictionary
    }
    
    func save(block: (user: User?, error: NSError?) -> ()) {
        var params = [String: AnyObject]()
        params["name"] = name
        params["bananaCount"] = bananaCount
        params["email"] = email
//        if let location = location {
//            params["location"] = ["lat": location.coordinate.latitude, "lon": location.coordinate.longitude]
//        }
        
        Alamofire.request(Discoverage.Router.UserUpdate(id, params)).responseJSON { (request, _, data, error) in
            if error == nil {
                self.reset(data as! NSDictionary)
                block(user: self, error: nil)
            } else {
                block(user: nil, error: error)
            }
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
        NSNotificationCenter.defaultCenter().postNotificationName("userDidLogout", object: nil)
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
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
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
