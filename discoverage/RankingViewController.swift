//
//  RankingViewController.swift
//  discoverage
//
//  Created by Jehan Tremback on 3/7/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var firstUsername: UILabel!
    @IBOutlet weak var secondUsername: UILabel!
    @IBOutlet weak var thirdUsername: UILabel!
    
    @IBAction func firstTap(sender: AnyObject) {
        self.performSegueWithIdentifier("userProfileSegue", sender: users?[0])
    }
    
    @IBAction func secondTap(sender: AnyObject) {
        self.performSegueWithIdentifier("userProfileSegue", sender: users?[1])
    }
    
    @IBAction func thirdTap(sender: AnyObject) {
        self.performSegueWithIdentifier("userProfileSegue", sender: users?[2])
    }
    
    var users: [User]?
    
    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "HomeTableViewCell"
        ) as RankingTableViewCell
        
        if let users = self.users {
            let user = users[indexPath.row + 3]
            cell.rankLabel.text = "\(indexPath.row + 3))"
            cell.usernameLabel.text = user.name
        }
        
        return cell
    }
    
    func tableView(
        tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        println("section: \(section)")
        if let users = self.users {
            return users.count
        } else {
            return 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tweetDetailSegue") {
            let dest = segue.destinationViewController as UserProfileViewController
            dest.user = sender as User
        } else {
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let dest = segue.destinationViewController as UserProfileViewController
            dest.user = users?[indexPath.row + 3]
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
}
