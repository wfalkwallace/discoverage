//
//  UserProfileViewController.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/10/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
