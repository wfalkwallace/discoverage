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

    @IBOutlet weak var bananaButtonView: UIView!
    @IBOutlet weak var heartsView: HeartsView!
    @IBOutlet weak var bananasCount: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        bananasCount.text = String(User.currentUser!.bananaCount)
        
        let displayHealth: Float = Float(animal.health) / 10.0
        heartsView.setHealth(displayHealth)
        
        self.tabBarController?.tabBar.hidden = true
        
        let sprite = animal.sprite
        animalImageView.image =  UIImage(named: sprite)
        let name = animal.name
        animalName.text = name
    }

    override func viewWillDisappear(animated: Bool) {
        delegate?.detailsViewControllerDelegate(self, didEndViewing: animal)
    }
    
    @IBAction func onFeed(sender: UIButton) {
        let oldHealth = animal!.health
        
        //update this view
        if (User.currentUser!.bananaCount > 0 &&  animal.health < 10) {
            self.bananasCount.text = "\(User.currentUser!.bananaCount - 1)"
            let displayHealth = Float(animal!.health + 1) / 10.0

            heartsView.setHealth(displayHealth)
            animal.feed({ (animal, success) -> () in
                if success {
                    self.animal = animal!
                   SpriteCell.animateSpriteTransition(self.animalImageView, label: self.animalName, sprite: self.animal.sprite, name: self.animal.name)
                } else {
                    // TODO alert network failed
                }
            })
        } else {
            //TODO can't feed alert
        }
    }
}
