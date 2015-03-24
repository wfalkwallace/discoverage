//
//  MenagerieViewController.swift
//  sprites
//
//  Created by Aditya Jayaraman on 3/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import Alamofire

class MenagerieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DetailsViewControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bananaCount: UILabel!

    var animals: [Animal]?
    var user: User?
    var canFeedInDetails: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if user == nil {
            user = User.currentUser!
            canFeedInDetails = true
        }
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.setupRefresh()
        
        let nib = UINib(nibName: "SpriteCell", bundle: NSBundle.mainBundle())
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "SpriteCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        bananaCount.text = String(user?.bananaCount ?? 0)
        getMenagerie()
    }
    
    func getMenagerie() {

        Alamofire.request(Discoverage.Router.AnimalsWithParams(["owner":user!.id])).responseJSON { (_, _, data, error) in
            if let data: AnyObject = data {
                self.animals = Animal.initWithArray(data as! [NSDictionary])
                self.collectionView.reloadData()
                self.collectionView.pullToRefreshView.stopAnimating()
            }
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
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
  
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        return sectionInsets
    }
  
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if canFeedInDetails {
            let detailsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailsViewController") as! DetailsViewController
            detailsViewController.animal = animals![indexPath.row]
            detailsViewController.delegate = self
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
    @IBAction func didTapLogout(sender: AnyObject) {
        User.logout()
    }
    
    func detailsViewControllerDelegate(detailsViewControllerDelegate: DetailsViewController, didEndViewing animal: Animal) {
        var index: Int? = nil
        if let animals = self.animals {
            index = find(animals, animal)
        }
        if let index = index {
            self.animals?.removeAtIndex(index)
            self.animals?.insert(animal, atIndex: index)
        }
    }

    func setupRefresh() {
        self.collectionView.addPullToRefreshWithActionHandler({ () -> Void in
            self.getMenagerie()
        })
    }
}
