//
//  RegisterViewController
//  discoverage
//
//  Created by William Falk-Wallace on 3/23/15.
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
                Alert.network(error)
            } else if let data: AnyObject = data {
                if let code: AnyObject = data.objectForKey("error") {
                    Alert.login(data)
                } else {
                    println(data)
                    let owner = User(dictionary: data as! NSDictionary)
                    var starter = Animal(owner: owner)
                    Alamofire.request(Discoverage.Router.AnimalCreate(starter.serialize())).responseJSON { (_, _, data: AnyObject?, error: NSError?) -> Void in
                        if let error = error {
                            Alert.network(error)
                        } else if let data: AnyObject = data {
                            println(data)
                            if let code: AnyObject = data.objectForKey("error") {
                                Alert.login(data)
                            } else {
                                self.login()
                            }
                        }
                    }
                }
            }
        }
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
                        LocationManager.sharedInstance.startUpdatingLocation()
                        let appStoryboard = UIStoryboard(name: "App", bundle: nil)
                        let appVC = appStoryboard.instantiateInitialViewController() as! UITabBarController
                        self.presentViewController(appVC, animated: true, completion: nil)
                    }
                }
        }
    }
}