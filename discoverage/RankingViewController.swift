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
     
        Alamofire.request(Discoverage.Router.UsersRanked()).responseJSON { (_, _, data: AnyObject?, error: NSError?) -> Void in
            if let dictionary = data as? [NSDictionary] {
                var users = User.initWithArray(dictionary)
                
                for user in users {
                    self.users!.append(user)
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let indexPath = sender as! NSIndexPath
//        let dest = segue.destinationViewController as! UserProfileViewController
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }

}
