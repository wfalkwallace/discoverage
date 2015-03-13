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
    
//        UIProgressView.animateWithDuration(5, animations: {
//            self.healthMeter.setProgress(animal.health, animated: true)
//        })
    }
}
