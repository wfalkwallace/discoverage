//
//  LoginViewController
//  discoverage
//
//  Created by William Falk-Wallace on 3/3/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import Accounts

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var b = BananaTree()
        b.location = PFGeoPoint(location: CLLocation(latitude: -37, longitude: 122))
        println(b)
        println(b.location)
        b.save()
        println("WFW")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

