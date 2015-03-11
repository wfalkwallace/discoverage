//
//  MenagerieViewController.swift
//  sprites
//
//  Created by Aditya Jayaraman on 3/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit


class MenagerieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DetailsViewControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bananaCount: UILabel!
    @IBOutlet weak var monstersLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    //temporary user object
    var user : User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SpriteCell", bundle: NSBundle.mainBundle())
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "SpriteCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        
        bananaCount.text = String(user.bananaCount)
        monstersLabel.text = String(user.menagerie.animals.count)
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.blackColor().CGColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
    
    /*override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    //#warning Incomplete method implementation -- Return the number of sections
    return 0
    }*/
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return user.menagerie.animals.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SpriteCell", forIndexPath: indexPath) as! SpriteCell
        
        cell.initFromDictionary(user.menagerie.animals[indexPath.row])
        return cell
    }
    
  
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        return sectionInsets
    }
  
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var storyboard = UIStoryboard(name: "details", bundle: nil)
        let detailsViewController = storyboard.instantiateViewControllerWithIdentifier("DetailsViewController") as! DetailsViewController
        
        detailsViewController.user = self.user
        detailsViewController.monsterIndexRow = indexPath.row
        detailsViewController.delegate = self

        let nav = self.navigationController
        if nav != nil {
            nav!.pushViewController(detailsViewController, animated: true)
        } else {
            self.presentViewController(detailsViewController, animated: true, completion: nil)
        }
    }
 
    func healthShouldChange(row: Int) -> Bool {
        //user has bananas
        if (user.bananaCount == 0) {
            return false
        }
        
        //monster health is not already 100
        let monster = user.menagerie.animals[row]
        let health = monster["health"] as? Float
        
        if (health == 1.0) {
            return false
        }
        return true
    }
    
    
    func healthDidChange(row: Int) {
        //decrement user banana count
        user.bananaCount -= 1
        
        //increate monster health
        var monster = user.menagerie.animals[row]
        var health = monster["health"] as! Float
        health += 0.1
        monster["health"] = health
        
        var indexPath : NSIndexPath = NSIndexPath(forRow: row, inSection: 0)
        self.collectionView!.reloadItemsAtIndexPaths([indexPath])
    }
    
}
