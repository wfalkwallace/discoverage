//
//  RankingViewController.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit
import Alamofire

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var bananaCount: UILabel!

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
                cell.usernameLabel.text = " \(user.name) "
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
                cell.usernameLabel.text = " \(user.name) "
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
    
//    //TODO: wire to userprofile instead of menagerie
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let menagerieStoryboard = UIStoryboard(name: "UserProfile", bundle: nil)
//        let userProfileViewController = menagerieStoryboard.instantiateViewControllerWithIdentifier("UserProfileViewController") as! UserProfileViewController
////        let users = self.users as [User]
////        userProfileViewController.user = users[indexPath.row]
//        
//        self.navigationController?.pushViewController(userProfileViewController, animated: true)
//    }

    @IBAction func didTapLogout(sender: AnyObject) {
        User.logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bananaCount.text = String(User.currentUser?.bananaCount ?? 0)
        
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
        self.users = [User]()
        
        self.navigationItem.title = "Leaderboard"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    
        setupRefresh()
        getLeaderboard()
    }
    
    func getLeaderboard() {
        Alamofire.request(Discoverage.Router.UsersRanked()).responseJSON { (_, _, data: AnyObject?, error: NSError?) -> Void in
            if let dictionary = data as? [NSDictionary] {
                self.users = User.initWithArray(dictionary)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dest = storyboard?.instantiateViewControllerWithIdentifier("userProfileViewController") as! UserProfileViewController
        dest.user = users[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        navigationController?.pushViewController(dest, animated: true)
        
    }

    func setupRefresh() {
        self.tableView.addPullToRefreshWithActionHandler({ () -> Void in
            self.getLeaderboard()
        })
    }
    
}
