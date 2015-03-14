//
//  DetailsViewController.swift
//  sprites
//
//  Created by Aditya Jayaraman on 3/8/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

protocol DetailsViewControllerDelegate {
    func healthShouldChange(row: Int) -> Bool
    func healthDidChange(row : Int)
}

class DetailsViewController: UIViewController {
//
//    var user: User?
//    var animalIndexRow : Int?
//
//    var delegate: DetailsViewControllerDelegate?
//    @IBOutlet weak var bananasCount: UILabel!
//    @IBOutlet weak var navigationBar: UINavigationBar!
//    @IBOutlet weak var animalImageView: UIImageView!
//    @IBOutlet weak var animalName: UILabel!
//    @IBOutlet weak var healthMeter: UIProgressView!
//    @IBOutlet weak var bananasEaten: UILabel!
//    @IBOutlet weak var animalMood: UILabel!
//    @IBOutlet weak var feedButton: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        var navigationItem = navigationBar.items[0] as! UINavigationItem
//        var button = UIBarButtonItem(title: "Menagerie", style: .Bordered, target: self, action: "onBack")
//        button.tintColor = UIColor.blackColor()
//        navigationItem.leftBarButtonItem = button
//        let animal = user!.animals[animalIndexRow!]
//        navigationItem.title = animal.name as? String
//
//        initView()
//    }
//
//    func initView() {
//        let animal = user?.animals[animalIndexRow!]
//
//        animalImageView.image =  UIImage(named: animal!.sprite as String)
//        animalName.text = animal!.name as String
//
//        UIProgressView.animateWithDuration(2.0, animations: {
//            self.healthMeter.setProgress(animal!.health as Float, animated: true)
//        })
//
//        bananasCount.text = String(user!.bananaCount)
//    }
//
//    func onBack() {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//
//    @IBAction func onFeed(sender: UIButton) {
//
//        if (delegate?.healthShouldChange(animalIndexRow!) == true) {
//            delegate?.healthDidChange(animalIndexRow!)
//        }
//
//        //update this view
//        bananasCount.text = String(user!.bananaCount)
//
//        let animal = user?.animals[animalIndexRow!]
//        var health = animal?.health as Float!
//
//        UIProgressView.animateWithDuration(2.0, animations: {
//            self.healthMeter.setProgress(health!,  animated: true)
//        })
//    }
}
