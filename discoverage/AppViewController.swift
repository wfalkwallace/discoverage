//
//  AppViewController.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/23/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class AppViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let menagerieStoryboard = UIStoryboard(name: "Menagerie", bundle: nil)
        let menagerieVC = menagerieStoryboard.instantiateInitialViewController() as! UINavigationController
        let menagerieTabImage = UIImage(named: "icon-home")

        let bananaMapStoryboard = UIStoryboard(name: "BananaMap", bundle: nil)
        let bananaMapVC = bananaMapStoryboard.instantiateInitialViewController() as! UIViewController
        let bananaMapTabImage = UIImage(named: "icon-map")

        let rankingStoryboard = UIStoryboard(name: "Ranking", bundle: nil)
        let rankingVC = rankingStoryboard.instantiateInitialViewController() as! UINavigationController
        let rankingTabImage = UIImage(named: "icon-leaderboard")

        let controllers = [menagerieVC, bananaMapVC, rankingVC]
        viewControllers = controllers

        menagerieVC.tabBarItem = UITabBarItem(title: "Menagerie", image: menagerieTabImage, tag: 1)
        bananaMapVC.tabBarItem = UITabBarItem(title: "Map", image: bananaMapTabImage, tag:2)
        rankingVC.tabBarItem = UITabBarItem(title: "Leaderboard", image: rankingTabImage, tag:3)
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
