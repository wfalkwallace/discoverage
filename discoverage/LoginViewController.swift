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
        
        let location = Location()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapLogin(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "BananaMap", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! BananaMapViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

}

