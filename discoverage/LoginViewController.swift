//
//  LoginViewController
//  discoverage
//
//  Created by William Falk-Wallace on 3/3/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {


    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
    }


    @IBAction func didTapSubmit(sender: AnyObject) {
        register()
    }
    
    func register () {
        Alamofire.request(Discoverage.Router.UserCreate(["name": usernameTextField.text, "email" : emailTextField.text, "password": passwordTextField.text])).responseJSON { (_, _, data: AnyObject?, error: NSError?) -> Void in
            if let error = error {
                // deal with login error
                let alert = UIAlertView()
                alert.title = "Alert"
                alert.message = "Signup failed. No network connection"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else if let data: AnyObject = data {
                if let code: AnyObject = data.objectForKey("error") {
                    println(data)
                    let alert = UIAlertView()
                    alert.title = "Alert"
                    alert.message = data.objectForKey("error") as? String
                    alert.addButtonWithTitle("OK")
                    alert.show()
                } else {
                    self.login()
                }
            }
        }
    }
    
    func login () {
        Alamofire.request(Discoverage.Router.Login(emailTextField.text, passwordTextField.text))
            .responseJSON { (_, _, data: AnyObject?, error: NSError?) -> Void in
            if let error = error {
                // deal with login error
                let alert = UIAlertView()
                alert.title = "Alert"
                alert.message = "Login failed. No network connection"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else if let data: AnyObject = data {
                if let code: AnyObject = data.objectForKey("error") {
                    println(data)
                    let alert = UIAlertView()
                    alert.title = "Alert"
                    alert.message = data.objectForKey("error") as? String
                    alert.addButtonWithTitle("OK")
                    alert.show()
                } else {
                    User.currentUser = User(dictionary: data as! NSDictionary)
                    let menagerieStoryboard = UIStoryboard(name: "Menagerie", bundle: nil)
                    let menagerieViewController = menagerieStoryboard.instantiateInitialViewController() as! UINavigationController
                    self.presentViewController(menagerieViewController, animated: true, completion: nil)
                }
            }
        }
    }
}

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
    
    @IBAction func didTapRegister(sender: AnyObject) {
        println("ReGiSTER") // todo: pop nav stack or w/e
    }
    
    func login () {
        Alamofire.request(Discoverage.Router.Login(emailTextField.text, passwordTextField.text))
            .responseJSON { (_, _, data: AnyObject?, error: NSError?) -> Void in
            if let error = error {
                // deal with login error
                let alert = UIAlertView()
                alert.title = "Alert"
                alert.message = "Login failed. No network connection"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else if let data: AnyObject = data {
                if let code: AnyObject = data.objectForKey("error") {
                    println(data)
                    let alert = UIAlertView()
                    alert.title = "Alert"
                    alert.message = data.objectForKey("error") as? String
                    alert.addButtonWithTitle("OK")
                    alert.show()
                } else {
                    User.currentUser = User(dictionary: data as! NSDictionary)
                    let menagerieStoryboard = UIStoryboard(name: "Menagerie", bundle: nil)
                    let menagerieViewController = menagerieStoryboard.instantiateInitialViewController() as! UINavigationController
                    self.presentViewController(menagerieViewController, animated: true, completion: nil)
                }
            }
        }
    }
}

