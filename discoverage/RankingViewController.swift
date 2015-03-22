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
    
//    @IBOutlet weak var firstUsername: UILabel!
//    @IBOutlet weak var secondUsername: UILabel!
//    @IBOutlet weak var thirdUsername: UILabel!
    @IBOutlet weak var tabBar: UITabBar!
    
//    @IBAction func firstTap(sender: AnyObject) {
//        self.performSegueWithIdentifier("userProfileSegue", sender: users[0])
//    }
//    
//    @IBAction func secondTap(sender: AnyObject) {
//        self.performSegueWithIdentifier("userProfileSegue", sender: users[1])
//    }
//    
//    @IBAction func thirdTap(sender: AnyObject) {
//        self.performSegueWithIdentifier("userProfileSegue", sender: users[2])
//    }

    var users: [User]! = []

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
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
            
            for i in 1...10 {
                for user in users {
                    self.users!.append(user)
                }
            }
            self.tableView.reloadData()
        }
        
        tabBar.selectedItem = tabBar.items![2] as? UITabBarItem
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tweetDetailSegue") {
            let dest = segue.destinationViewController as! UserProfileViewController
            dest.user = sender as! User
        } else {
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let dest = segue.destinationViewController as! MenagerieViewController
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
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
