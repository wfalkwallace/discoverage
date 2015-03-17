//
//  MenagerieViewController.swift
//  sprites
//
//  Created by Aditya Jayaraman on 3/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import Alamofire

class MenagerieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DetailsViewControllerDelegate, UITabBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bananaCount: UILabel!
    @IBOutlet weak var tabBar: UITabBar!
    
    var user: User?
    var animals: [Animal]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user = User.currentUser
        
        let nib = UINib(nibName: "SpriteCell", bundle: NSBundle.mainBundle())
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "SpriteCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        bananaCount.text = String(self.user!.bananaCount)

        self.animals = [Animal]()
        Alamofire.request(Discoverage.Router.Animals("")).responseJSON { (_, _, data, error) in
            // todo: save dict and call block
            var animalss = Animal.initWithArray(data as! [NSDictionary])
            
            for i in 1...10 {
                for animal in animalss {
                    self.animals!.append(animal)
                }
            }
            self.collectionView.reloadData()
            println(data)
            println(error)
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        
        detailsViewController.animal = animals![indexPath.row]
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
        
        //monster health is not already 10
        let animal = animals![row]
        let health = animal.health
        
        if (health == 10) {
            return false
        }
        return true
    }
    
    
    //TODO: move this into the models
    func feed(row: Int, block: (user: User?, animal: Animal?, success: Bool) -> ()) {
        
        
        if (user!.bananaCount == 0) {
            block(user: nil, animal: nil, success: false)
        }
        
        //monster health is not already 10
        let animal = animals![row]
        var health = animal.health
        
        if (health == 10) {
            block(user: nil, animal: nil, success: false)
        }
        
        //decrement user banana count
        user!.bananaCount -= 1
        user!.save { (user, error) -> () in
            if error == nil {
                User.currentUser = user
                println(User.currentUser!.name)
                println(User.currentUser!.id)
                
                health = health + 1
                animal.health = health
                
                animal.save({ (animal, error) -> () in
                    if error == nil {
                        var indexPath : NSIndexPath = NSIndexPath(forRow: row, inSection: 0)
                        self.collectionView!.reloadItemsAtIndexPaths([indexPath])
                        block(user: self.user, animal: animal, success: true)
                    } else {
                        block(user: nil, animal: nil, success: false)
                    }
                })
                
            } else {
                block(user: nil, animal: nil, success: false)
            }
        }
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if item.title == (tabBar.items![1] as! UITabBarItem).title {
            let mapStoryboard = UIStoryboard(name: "BananaMap", bundle: nil)
            let mapViewController = mapStoryboard.instantiateInitialViewController() as! BananaMapViewController
            self.presentViewController(mapViewController, animated: true, completion: nil)
        } else if item.title == (tabBar.items![2] as! UITabBarItem).title {
            let rankingStoryboard = UIStoryboard(name: "Ranking", bundle: nil)
            let rankingViewController = rankingStoryboard.instantiateInitialViewController() as! UINavigationController
            self.presentViewController(rankingViewController, animated: true, completion: nil)
        }
    }

}
