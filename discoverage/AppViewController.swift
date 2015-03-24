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
        let menagerieTabImage = UIImage(named: "icon-home-white")?.imageWithRenderingMode(.AlwaysOriginal)

        let bananaMapStoryboard = UIStoryboard(name: "BananaMap", bundle: nil)
        let bananaMapVC = bananaMapStoryboard.instantiateInitialViewController() as! UIViewController
        let bananaMapTabImage = UIImage(named: "icon-map-white")?.imageWithRenderingMode(.AlwaysOriginal)

        let rankingStoryboard = UIStoryboard(name: "Ranking", bundle: nil)
        let rankingVC = rankingStoryboard.instantiateInitialViewController() as! UINavigationController
        let rankingTabImage = UIImage(named: "icon-leaderboard-white")?.imageWithRenderingMode(.AlwaysOriginal)

        let controllers = [menagerieVC, bananaMapVC, rankingVC]
        viewControllers = controllers

        menagerieVC.tabBarItem = UITabBarItem(title: "Menagerie", image: menagerieTabImage, tag: 1)
        menagerieVC.tabBarItem.selectedImage = UIImage(named: "icon-home")
        menagerieVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        menagerieVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.yellowColor()], forState: .Selected)
        
        bananaMapVC.tabBarItem = UITabBarItem(title: "Map", image: bananaMapTabImage, tag:2)
        bananaMapVC.tabBarItem.selectedImage = UIImage(named: "icon-map")
        bananaMapVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        bananaMapVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.yellowColor()], forState: .Selected)
        
        rankingVC.tabBarItem = UITabBarItem(title: "Leaderboard", image: rankingTabImage, tag:3)
        rankingVC.tabBarItem.selectedImage = UIImage(named: "icon-leaderboard")
        rankingVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        rankingVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.yellowColor()], forState: .Selected)

        let red = UIColor(red: 193 / 255, green: 48 / 255, blue: 29 / 255, alpha: 1)
        let yellow = UIColor(red: 255 / 255, green: 223 / 255, blue: 42 / 255, alpha: 1)
        
        tabBar.barTintColor = red
        tabBar.tintColor = yellow
        selectedIndex = 1
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
