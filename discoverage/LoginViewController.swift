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

    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapLogin(sender: UIButton) {
        let mapStoryboard = UIStoryboard(name: "BananaMap", bundle: nil)
        let mapViewController = mapStoryboard.instantiateInitialViewController() as! BananaMapViewController
        self.presentViewController(mapViewController, animated: true, completion: nil)
    }

}

