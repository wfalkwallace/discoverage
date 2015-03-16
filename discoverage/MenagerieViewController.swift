//
//  MenagerieViewController.swift
//  sprites
//
//  Created by Aditya Jayaraman on 3/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MenagerieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DetailsViewControllerDelegate, UITabBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bananaCount: UILabel!
    @IBOutlet weak var tabBar: UITabBar!
    
    var user: User?
    var animals: [Animal]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user = User.currentUser
        bananaCount.text = String(self.user!.bananaCount)
        
        let nib = UINib(nibName: "SpriteCell", bundle: NSBundle.mainBundle())
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "SpriteCell")
        
        Animal.animalsForUserAndCompletion(self.user!.name) {
            (animals: [Animal]?, error: NSError?) in
            if animals != nil {
                self.animals = animals
                println(self.animals!.count)
                self.collectionView.reloadData()
            } else {
                //handle getting animals failure
            }
        }

    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        if animals != nil {
            return animals!.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SpriteCell", forIndexPath: indexPath) as! SpriteCell
        cell.populate(animals![indexPath.row])
        return cell
    }
    
  
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        return sectionInsets
    }
  
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailsViewController") as! DetailsViewController
        
        detailsViewController.user = self.user
        detailsViewController.animalIndexRow = indexPath.row
        detailsViewController.delegate = self

        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
 
    func healthShouldChange(row: Int) -> Bool {
        //user has bananas
        if (user?.bananaCount == 0) {
            return false
        }
        
        //monster health is not already 100
        let animal = animals![row]
        let health = animal.health
        
        if (health == 1) {
            return false
        }
        return true
    }
    
    
    func healthDidChange(row: Int) {
        //decrement user banana count
        user!.bananaCount -= 1
        
        //increate monster health
        var animal = animals![row]
        var health = animal.health
        health = health + 10
        animal.health = health
        
        var indexPath : NSIndexPath = NSIndexPath(forRow: row, inSection: 0)
        self.collectionView!.reloadItemsAtIndexPaths([indexPath])
    }    
}
