//
//  SpriteCell.swift
//  sprites
//
//  Created by Aditya Jayaraman on 3/7/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class SpriteCell: UICollectionViewCell {

    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var monsterName: UILabel!
    @IBOutlet weak var healthMeter: HeartsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func populate(animal: Animal) {
    
        let displayHealth: Float = Float(animal.health) / 10.0
        self.healthMeter.setHealth(displayHealth)
        monsterName.text = animal.name
        monsterImageView.image = UIImage(named: animal.sprite)
    }
    
    class func animateSpriteTransition(image: UIImageView, label: UILabel, sprite: String, name: String) {
        let toImage = UIImage(named: sprite)
        UIView.transitionWithView(image,
            duration:2,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: {
                image.image = toImage
                label.text = name
        }, completion: nil)
    }
    
    //This code is gnarly, and probably not the best use of a class method
    class func displaySprite(image: UIImageView, label: UILabel, animal: Animal, animate: Bool) {

        switch(animal.names.count) {
        case 1:
            label.text = animal.names[0] as! String
            image.image = UIImage(named: animal.sprites[0] as! String)
        case 2:
            switch(animal.health) {
            case 0...5:
                label.text = animal.names[0] as! String
                image.image = UIImage(named: animal.sprites[0] as! String)
            case 6...10:
                if animate {
                    let toImage = UIImage(named: animal.sprites[1] as! String)
                    UIView.transitionWithView(image,
                        duration:2,
                        options: UIViewAnimationOptions.TransitionCrossDissolve,
                        animations: {
                            image.image = toImage
                            label.text = animal.names[1] as! String
                        }, completion: nil)
                } else {
                    label.text = animal.names[1] as! String
                    image.image = UIImage(named: animal.sprites[1] as! String)
                }
            default:
                break
            }
        case 3:
            switch animal.health {
            case 0...4:
                label.text = animal.names[0] as! String
                image.image = UIImage(named: animal.sprites[0] as! String)
            case 5...8:
                if animate {
                    let toImage = UIImage(named: animal.sprites[1] as! String)
                    UIView.transitionWithView(image,
                        duration:2,
                        options: UIViewAnimationOptions.TransitionCrossDissolve,
                        animations: {
                            label.text = animal.names[1] as! String
                            image.image = toImage
                        }, completion: nil)
                } else {
                    label.text = animal.names[1] as! String
                    image.image = UIImage(named: animal.sprites[1] as! String)
                }
            case 9...10:
                if animate {
                    let toImage = UIImage(named: animal.sprites[2] as! String)
                    UIView.transitionWithView(image,
                        duration:2,
                        options: UIViewAnimationOptions.TransitionCrossDissolve,
                        animations: {
                            label.text = animal.names[2] as! String
                            image.image = toImage
                        }, completion: nil)
                
                } else {
                    label.text = animal.names[2] as! String
                    image.image = UIImage(named: animal.sprites[2] as! String)
                }
            default:
                break
            }
        default:
            label.text = animal.names[0] as! String
            image.image = UIImage(named: animal.sprites[0] as! String)
        }
    }
    
}
