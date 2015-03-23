//
//  MenagerieViewController.swift
//  sprites
//
//  Created by Aditya Jayaraman on 3/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import Alamofire

class UserProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var animals: [Animal]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "SpriteCell", bundle: NSBundle.mainBundle())
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "SpriteCell")
    }
    
    
    // Eh Jack's //
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
     
        collectionView.reloadData()
        
        Alamofire.request(Discoverage.Router.AnimalsWithParams(["owner":User.currentUser!.id])).responseJSON { (_, _, data, error) in
            // todo: save dict and call block
            println("JNT 0113 \(data)")
            if let data: AnyObject = data {
                self.animals = Animal.initWithArray(data as! [NSDictionary])
                self.collectionView.reloadData()
            }
        }
    }
    
    
    // Cell Display //
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
    
    
    // Sizing and Spacing //
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
  
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
        return sectionInsets
    }
}
