//
//  Alerts.swift
//  discoverage
//
//  Created by Aditya Jayaraman on 3/23/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

class Alert {
    
    class func network(error: AnyObject) {
        let alert = UIAlertView()
        alert.title = "Network Error"
        alert.message = "No network connection"
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
    class func login(error: AnyObject) {
        println(error)
        let alert = UIAlertView()
        alert.title = "Error"
        let code = error.objectForKey("code") as! Int
        let message = error.objectForKey("error") as! String
        alert.message = "\(code) : \(message)"
        alert.addButtonWithTitle("OK")
        alert.show()
    }
}
