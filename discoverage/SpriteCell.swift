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
        let name = animal.name
        monsterName.text = name
        let sprite = animal.sprite
        monsterImageView.image = UIImage(named: sprite)
    }
    
    class func animateSpriteTransition(image: UIImageView, label: UILabel, sprite: String, name: String) {
        let toImage = UIImage(named: sprite)
        
        UIView.transitionWithView(image, duration: 2, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            image.image = toImage
        }) { (success) -> Void in
            label.text = name
        }
        
    }
}
