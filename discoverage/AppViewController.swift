//
//  AppViewController.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/14/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {

    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let menagerieStoryboard = UIStoryboard(name: "Menagerie", bundle: nil)
        let menagerieViewController = menagerieStoryboard.instantiateInitialViewController() as! MenagerieViewController
        menagerieViewController.view.frame = containerView.frame
        containerView.addSubview(menagerieViewController.view)
        tabBar.selectedItem = 0
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
