//
//  DetailsViewController.swift
//  sprites
//
//  Created by Aditya Jayaraman on 3/8/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

protocol DetailsViewControllerDelegate {
    func detailsViewControllerDelegate(detailsViewControllerDelegate: DetailsViewController, didEndViewing animal: Animal)
}

class DetailsViewController: UIViewController {

    var animal: Animal!
    var delegate: DetailsViewControllerDelegate?

    @IBOutlet weak var bananasCount: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var healthMeter: UIProgressView!
    @IBOutlet weak var bananasEaten: UILabel!
    @IBOutlet weak var animalMood: UILabel!
    @IBOutlet weak var feedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = animal.name as String

        animalImageView.image =  UIImage(named: animal.sprite as String)
        animalName.text = animal.name as String
        let displayHealth:Float = Float(animal.health) / 10.0
        
        UIProgressView.animateWithDuration(2.0, animations: {
            self.healthMeter.setProgress(displayHealth, animated: true)
        })
        
        bananasCount.text = String(User.currentUser!.bananaCount)
    }

    // TODO this should be a delegate
    func onBack() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onFeed(sender: UIButton) {
        //update this view
        self.bananasCount.text = "\(User.currentUser!.bananaCount - 1)"
        let displayHealth = Float(animal!.health + 1) / 10.0
        UIProgressView.animateWithDuration(2.0, animations: {
            self.healthMeter.setProgress(displayHealth,  animated: true)
        })
        
        animal.feed({ (animal, success) -> () in
            //reload data or alert
        })
    }
}
