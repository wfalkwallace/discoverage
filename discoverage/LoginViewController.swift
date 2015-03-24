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

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.layer.borderWidth = 2
        registerButton.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func didTapSubmit(sender: AnyObject) {
        login()
    }
    
    func login () {
        Alamofire.request(Discoverage.Router.Login(emailTextField.text, passwordTextField.text))
            .responseJSON { (_, _, data: AnyObject?, error: NSError?) -> Void in
            if let error = error {
                Alert.network(error)
            } else if let data: AnyObject = data {
                if let code: AnyObject = data.objectForKey("error") {
                    Alert.login(data)
                } else {
                    User.currentUser = User(dictionary: data as! NSDictionary)
                    let appStoryboard = UIStoryboard(name: "App", bundle: nil)
                    let appVC = appStoryboard.instantiateInitialViewController() as! UITabBarController
                    self.presentViewController(appVC, animated: true, completion: nil)
                }
            }
        }
    }
}

