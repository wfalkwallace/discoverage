//
//  LoginViewController
//  discoverage
//
//  Created by William Falk-Wallace on 3/3/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Alamofire.request(Discoverage.Router.Animals("")).responseJSON { (_, _, data, error) in
            // todo: save dict and call block
            println(data)
            println(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapLogin(sender: UIButton) {
//        var user = User(name: "WFW", email: "", bananaCount: 5)
//        user.save { (success, error) -> () in
            // do nothing
//        }
//        println(user.name)
//        println(user.id)
//        User.currentUser = user
        
        let menagerieStoryboard = UIStoryboard(name: "Menagerie", bundle: nil)
        let menagerieViewController = menagerieStoryboard.instantiateInitialViewController() as! UINavigationController
        self.presentViewController(menagerieViewController, animated: true, completion: nil)
    }

}

