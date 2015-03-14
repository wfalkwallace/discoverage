//
//  AppViewController.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/14/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class AppViewController: UIViewController, UITabBarDelegate {

    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if let title = item.title {
            if title == "Home" {
                let menagerieStoryboard = UIStoryboard(name: "Menagerie", bundle: nil)
                let menagerieViewController = menagerieStoryboard.instantiateInitialViewController() as! MenagerieViewController
                menagerieViewController.view.frame = containerView.frame
                containerView.addSubview(menagerieViewController.view)
            } else if title == "Map" {
                let mapStoryboard = UIStoryboard(name: "Menagerie", bundle: nil)
                let mapViewController = menagerieStoryboard.instantiateInitialViewController() as! MenagerieViewController
                menagerieViewController.view.frame = containerView.frame
                containerView.addSubview(menagerieViewController.view)
            } else {
                
            }
        }
        
    }

}
