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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapLogin(sender: UIButton) {
        Alamofire.request(Discoverage.Router.Login(emailTextField.text, passwordTextField.text))
            .responseJSON { (_, _, data: AnyObject?, error: NSError?) -> Void in
            if let error = error {
                // deal with login error
                println(error)
                let alert = UIAlertView()
                alert.title = "Alert"
                alert.message = "Incorrect username or password!"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else {
                // TODO deal with 401 user not found error in data.
                User.currentUser = User(dictionary: data as! NSDictionary)
                
                let menagerieStoryboard = UIStoryboard(name: "Menagerie", bundle: nil)
                let menagerieViewController = menagerieStoryboard.instantiateInitialViewController() as! UINavigationController
                self.presentViewController(menagerieViewController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func didTapSignup(sender: UIButton) {
        Alamofire.request(Discoverage.Router.UserCreate(["name": usernameTextField.text, "email" : emailTextField.text, "password": passwordTextField.text])).responseJSON { (_, _, data: AnyObject?, error: NSError?) -> Void in
            if let error = error {
                // deal with signup error error
                println(error)
            } else {
                println(data)
                self.didTapLogin(sender)
            }
        }
    }

}

