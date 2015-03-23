//
//  RankingViewController.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import Alamofire

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!

    var users: [User]! = []

    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        if (indexPath.row < 3) {
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "TopRankingTableViewCell"
            ) as! TopRankingTableViewCell
            
            if users.count > 0 {
                let users = self.users as [User]
                let user = users[indexPath.row]
                cell.usernameLabel.text = user.name
            }
            
            switch indexPath.row {
                case 0:
                    cell.medalImage.image = UIImage(named: "gold_medal")
                    cell.rankLabel.text = "1"
                case 1:
                    cell.medalImage.image = UIImage(named: "silver_medal")
                    cell.rankLabel.text = "2"
                default:
                    cell.medalImage.image = UIImage(named: "bronze_medal")
                    cell.rankLabel.text = "3"
            }

            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "RankingTableViewCell"
            ) as! RankingTableViewCell
            
            if users.count > 0 {
                let users = self.users as [User]
                let user = users[indexPath.row]
                cell.rankLabel.text = "\(indexPath.row + 1)"
                cell.usernameLabel.text = user.name
            }

            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row < 3) {
            return 70
        } else {
            return 50
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    //TODO: wire to userprofile instead of menagerie
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let menagerieStoryboard = UIStoryboard(name: "Menagerie", bundle: nil)
        let userProfileViewController = menagerieStoryboard.instantiateViewControllerWithIdentifier("MenagerieViewController") as! MenagerieViewController
        let users = self.users as [User]
        userProfileViewController.user = users[indexPath.row]
        
        self.navigationController?.pushViewController(userProfileViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
        self.users = [User]()
     
        Alamofire.request(Discoverage.Router.UsersWithParams([:])).responseJSON { (_, _, data, error) in
            // todo: save dict and call block
            var users = User.initWithArray(data as! [NSDictionary])
            
            for user in users {
                self.users!.append(user)
            }
            self.tableView.reloadData()
        }
        
        tabBar.selectedItem = tabBar.items![2] as? UITabBarItem
    }
    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let indexPath = sender as! NSIndexPath
//        let dest = segue.destinationViewController as! UserProfileViewController
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if item.title == (tabBar.items![0] as! UITabBarItem).title {
            let menagerieStoryboard = UIStoryboard(name: "Menagerie", bundle: nil)
            let menagerieViewController = menagerieStoryboard.instantiateInitialViewController() as! UINavigationController
            self.presentViewController(menagerieViewController, animated: true, completion: nil)
        } else if item.title == (tabBar.items![1] as! UITabBarItem).title {
            let mapStoryboard = UIStoryboard(name: "BananaMap", bundle: nil)
            let mapViewController = mapStoryboard.instantiateInitialViewController() as! BananaMapViewController
            self.presentViewController(mapViewController, animated: true, completion: nil)
        }
    }

}
