//
//  MenagerieViewController.swift
//  sprites
//
//  Created by Aditya Jayaraman on 3/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import Alamofire

class MenagerieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITabBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bananaCount: UILabel!
    @IBOutlet weak var tabBar: UITabBar!
    
    var user: User?
    var animals: [Animal]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user = User.currentUser

        tabBar.selectedItem = tabBar.items![0] as? UITabBarItem

        let nib = UINib(nibName: "SpriteCell", bundle: NSBundle.mainBundle())
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "SpriteCell")
        
        var logoutButton = UIBarButtonItem(title: "Logout", style: .Bordered, target: self, action: "logout")
        logoutButton.tintColor = UIColor.whiteColor()
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.leftBarButtonItem!.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "PokemonSolidNormal", size: 12)!], forState: UIControlState.Normal)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        bananaCount.text = String(self.user!.bananaCount)

        self.animals = [Animal]()
     
        //Alamofire.request(Discoverage.Router.AnimalsWithParams(["owner":User.currentUser!.id])).
        Alamofire.request(Discoverage.Router.AnimalsWithParams(["owner":User.currentUser!.id])).responseJSON { (_, _, data, error) in
            // todo: save dict and call block
            self.animals = Animal.initWithArray(data as! [NSDictionary])
            self.collectionView.reloadData()
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
        println("JNT 24242 \(animals![indexPath.row])")
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
    
    func logout() {
        User.logout()
    }

}
