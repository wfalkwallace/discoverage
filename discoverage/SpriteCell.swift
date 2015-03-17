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
    @IBOutlet weak var healthMeter: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func populate(animal: Animal) {
        monsterImageView.image = UIImage(named: animal.sprite as String)
        monsterName.text = animal.name as String
    
        let displayHealth:Float = Float(animal.health) / 10.0
        self.healthMeter.setProgress(displayHealth, animated: true)
        
        UIView.animateWithDuration(3.0, animations: {
            self.healthMeter.setProgress(displayHealth,  animated: true)
        })
        
    }
}
