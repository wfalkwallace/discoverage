//
//  DetailsViewController.swift
//  sprites
//
//  Created by Aditya Jayaraman on 3/8/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

protocol DetailsViewControllerDelegate {
    func feed(row: Int, block: (user: User?, animal: Animal?, success: Bool) -> ())
}

class DetailsViewController: UIViewController {

    var user: User?
    var animal : Animal?
    var animalIndexRow : Int?

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
        navigationItem.title = animal!.name as? String
        initView()
    }

    func initView() {

        animalImageView.image =  UIImage(named: animal!.sprite as String)
        animalName.text = animal!.name as String
        let displayHealth:Float = Float(animal!.health) / 10.0
        
        UIProgressView.animateWithDuration(2.0, animations: {
            self.healthMeter.setProgress(displayHealth, animated: true)
        })

        bananasCount.text = String(user!.bananaCount)
    }

    func onBack() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onFeed(sender: UIButton) {

        println("onfeed")
        delegate?.feed(animalIndexRow!, block: { (user, animal, success) -> () in
            
            if success == true {
                self.user = user!
                self.animal = animal!
                
                //update this view
                self.bananasCount.text = String(user!.bananaCount)
                
                let displayHealth:Float = Float(animal!.health) / 10.0
                
                UIProgressView.animateWithDuration(2.0, animations: {
                    self.healthMeter.setProgress(displayHealth,  animated: true)
                })
            }
        })

    }
}
